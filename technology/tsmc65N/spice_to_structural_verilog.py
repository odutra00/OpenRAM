#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
================================================================================
     SPICE to Structural Verilog Converter with Hierarchical Flattening
================================================================================
Autor: Assistente IA / Odilon
Data: 2026
Descrição:
    Converte netlists SPICE do OpenRAM para Verilog Estrutural (TSMC 65nm).
    Algumas instancias são removidas de sua hierarquia e subidas ao topo. O
    script faz esse flattening de forma inteligente, refazendo as ligações no topo e
    reajando os pinos da instancia que perdeu a subinstancia.
    Alem disso, devido aos problemas de roteamento do OpenRAM, mesmo ligacoes
    a rails de vdd e gnd, por exemplo na capped_replica_bitcell_array, foram removidos.
    Além disso o openram nao fazia o tie-dow das bl e br das celulas dummy. Corrigi isso.
    Esses pinos foram colocados na interface da celula e o innovus irá rotea-las.
    Para isso,
    o script injeta dinamicamente na macro 'capped_replica_bitcell_array' todas as
    Wordlines dummy, Bitlines dummy e trilhos de alimentação (vdd_X / gnd_X)
    gerados de forma customizada no Python, costurando-os ao vdd/gnd do topo.
================================================================================
"""
import sys
import os
import re

CELL_MAP = {
    'pnand2': ('N2D0',  ['A', 'B', 'Z', 'vdd', 'gnd'],     ['A1', 'A2', 'Z', 'VDD', 'VSS']),
    'pand2':  ('AN2D0', ['A', 'B', 'Z', 'vdd', 'gnd'],     ['A1', 'A2', 'Z', 'VDD', 'VSS']),
    'pand3':  ('AN3D0', ['A', 'B', 'C', 'Z', 'vdd', 'gnd'],['A1', 'A2', 'A3', 'Z', 'VDD', 'VSS']),
    'pinv':   ('INVD0', ['A', 'Z', 'vdd', 'gnd'],          ['I', 'ZN', 'VDD', 'VSS']),
    'dff':    ('DFQD1', ['D', 'Q', 'clk', 'vdd', 'gnd'],    ['D', 'Q', 'CP', 'VDD', 'VSS'])
}

MACRO_BLACKBOXES = [
    'capped_replica_bitcell_array', 'sense_amp_array', 'precharge_array', 'write_driver_array'
]

SUB_HIERARCHIES_TO_IGNORE = [
    'dummy_cell_1rw', 'replica_cell_1rw', 'cell_1rw', 'write_driver', 'precharge', 'sense_amp',
    'dummy_array', 'dummy_array_0', 'dummy_array_1', 'dummy_array_2', 'dummy_array_3',
    'replica_column', 'bitcell_array', 'Xbitcell_array', 'replica_bitcell_array', 'bank', 'port_data'
]

class SpiceInstance:
    def __init__(self, name, nets, cell_type):
        self.name = name
        self.nets = nets
        self.cell_type = cell_type

class SpiceSubckt:
    def __init__(self, name, pins):
        self.name = name
        self.pins = pins
        self.instances = []

def preprocess_spice(lines):
    cleaned_lines = []
    current_line = ""
    for line in lines:
        line_clean = line.strip()
        if not line_clean or line_clean.startswith('*'):
            continue
        if line_clean.startswith('+'):
            current_line += " " + line_clean[1:].strip()
        else:
            if current_line: cleaned_lines.append(current_line)
            current_line = line_clean
    if current_line: cleaned_lines.append(current_line)
    return cleaned_lines

def parse_spice(spice_lines):
    subckts = {}
    current_subckt = None
    for line in spice_lines:
        tokens = line.split()
        if not tokens: continue
        cmd = tokens[0].lower()
        if cmd == '.subckt':
            name = tokens[1]
            pins = tokens[2:]
            current_subckt = SpiceSubckt(name, pins)
            subckts[name] = current_subckt
        elif cmd == '.ends':
            current_subckt = None
        elif tokens[0].upper().startswith('X') and current_subckt is not None:
            inst_name = tokens[0]
            cell_type = tokens[-1]
            inst_nets = tokens[1:-1]
            current_subckt.instances.append(SpiceInstance(inst_name, inst_nets, cell_type))
    return subckts

def get_clean_suffix(cell_name, prefix):
    if prefix and cell_name.lower().startswith(prefix.lower() + "_"):
        return cell_name[len(prefix) + 1:]
    return cell_name

def flatten_netlist(subckts, top_module_name):
    for subckt_name, subckt in subckts.items():
        base_name = get_clean_suffix(subckt_name, top_module_name).lower()
        if base_name in [m.lower() for m in MACRO_BLACKBOXES]:
            subckt.instances = []

    made_changes = True
    while made_changes:
        made_changes = False
        for subckt_name, subckt in list(subckts.items()):
            new_instances = []
            for inst in subckt.instances:
                base_cell_type = get_clean_suffix(inst.cell_type, top_module_name).lower()
                if base_cell_type in [s.lower() for s in SUB_HIERARCHIES_TO_IGNORE]:
                    target_key = next((k for k in subckts if k.lower() == inst.cell_type.lower()), None)
                    if target_key:
                        target_subckt = subckts[target_key]
                        pin_to_net_map = dict(zip(target_subckt.pins, inst.nets))
                        for child_inst in target_subckt.instances:
                            resolved_nets = []
                            for net in child_inst.nets:
                                if net in pin_to_net_map:
                                    resolved_nets.append(pin_to_net_map[net])
                                else:
                                    resolved_nets.append(f"{inst.name}_{net}")
                            new_inst_name = f"{inst.name}_{child_inst.name}"
                            new_instances.append(SpiceInstance(new_inst_name, resolved_nets, child_inst.cell_type))
                        made_changes = True
                    else:
                        new_instances.append(inst)
                else:
                    new_instances.append(inst)
            subckt.instances = new_instances

    for subckt_name in list(subckts.keys()):
        base_name = get_clean_suffix(subckt_name, top_module_name).lower()
        if base_name in [s.lower() for s in SUB_HIERARCHIES_TO_IGNORE]:
            del subckts[subckt_name]

def write_verilog(subckts, top_module_name, original_subckts_dict):
    verilog_lines = []
    max_wl_count = 0
    max_bl_count = 0
    
    # Busca inteligente para extrair limites da matriz
    for s_name, s_obj in original_subckts_dict.items():
        clean_name = s_name.lower().replace(top_module_name.lower(), "").replace("tsmc65n", "").strip("_")
        if clean_name == 'capped_replica_bitcell_array':
            for pin in s_obj.pins:
                wl_match = re.search(r'wl_(\d+)', pin, re.IGNORECASE)
                bl_match = re.search(r'b[lr]_(\d+)', pin, re.IGNORECASE)
                if wl_match:
                    max_wl_count = max(max_wl_count, int(wl_match.group(1)) + 1)
                if bl_match:
                    max_bl_count = max(max_bl_count, int(bl_match.group(1)) + 1)
            break
            
    if max_wl_count == 0: max_wl_count = 16
    if max_bl_count == 0: max_bl_count = 16
    
    dummy_wl_pins = [f"dummy_wl_{i}" for i in range(max_wl_count + 2)]
    dummy_bl_pins = [f"dummy_bl_{i}" for i in range(max_bl_count + 2)]
    dummy_br_pins = [f"dummy_br_{i}" for i in range(max_bl_count + 2)]
    
    total_supply_lines = 20 
    vdd_pins = [f"vdd_{i}" for i in range(total_supply_lines) if i % 2 != 0]
    gnd_pins = [f"gnd_{i}" for i in range(total_supply_lines) if i % 2 == 0]
    
    all_injected_dummies = dummy_wl_pins + dummy_bl_pins + dummy_br_pins + vdd_pins + gnd_pins

    for subckt_name, subckt in subckts.items():
        if subckt_name in CELL_MAP:
            continue

        # Aplica a mesma limpeza robusta na hora de tratar o módulo
        clean_base = subckt_name.lower().replace(top_module_name.lower(), "").replace("tsmc65n", "").strip("_")
        current_pins = list(subckt.pins)
        
        if clean_base == 'capped_replica_bitcell_array':
            current_pins += all_injected_dummies

        # ----------------------------------------------------------------------
        # CHECAGEM: É O MÓDULO TOPO?
        # ----------------------------------------------------------------------
        is_top_module = (subckt_name.lower() == top_module_name.lower())

        if is_top_module:
            # 1. TRATAMENTO APENAS PARA O MÓDULO TOPO: VETORIZAÇÃO COMPATÍVEL COM INNOVUS
            ports_dict = {}
            for pin in current_pins:
                match = re.match(r'^([a-zA-Z0-9_]+?)(?:_(\d+)|\[(\d+)\])?$', pin)
                if match and (match.group(2) is not None or match.group(3) is not None):
                    base_name = match.group(1)
                    idx = int(match.group(2) if match.group(2) is not None else match.group(3))
                else:
                    base_name = pin
                    idx = None

                if base_name not in ports_dict:
                    ports_dict[base_name] = {'direction': 'inout', 'indices': []}

                if idx is not None:
                    ports_dict[base_name]['indices'].append(idx)

            header_ports = list(ports_dict.keys())
            verilog_lines.append(f"\nmodule {subckt_name} (")
            verilog_lines.append("  " + ",\n  ".join(header_ports))
            verilog_lines.append(");")
            verilog_lines.append("")

            for base_name, info in ports_dict.items():
                direction = info['direction']
                indices = info['indices']
                if indices:
                    msb = max(indices)
                    lsb = min(indices)
                    verilog_lines.append(f"  {direction} [{msb}:{lsb}] {base_name};")
                else:
                    verilog_lines.append(f"  {direction} {base_name};")

            verilog_lines.append("")

        else:
            # 2. SUBMÓDULOS INTERNOS E MACROS: MANTÉM DECLARAÇÃO ESCALAR ORIGINAL
            verilog_lines.append(f"\nmodule {subckt_name} (")
            verilog_lines.append("  " + ", ".join(current_pins))
            verilog_lines.append(");")
            for pin in current_pins:
                verilog_lines.append(f"  inout {pin};")
            verilog_lines.append("")

        # Trata as macros Blackbox
        if clean_base in [m.lower() for m in MACRO_BLACKBOXES]:
            verilog_lines.append("endmodule\n")
            continue
            
        # Conexões das instâncias internas
        for inst in subckt.instances:
            if inst.cell_type in CELL_MAP:
                tsmc_cell, _, tsmc_pins = CELL_MAP[inst.cell_type]
                mapped_ports = []
                for idx, net in enumerate(inst.nets):
                    if idx < len(tsmc_pins):
                        mapped_ports.append(f".{tsmc_pins[idx]}({net})")
                    else:
                        mapped_ports.append(f".PIN_{idx}({net})")
                verilog_lines.append(f"  {tsmc_cell} {inst.name} ({', '.join(mapped_ports)});")
            else:
                target_key = next((k for k in original_subckts_dict if k.lower() == inst.cell_type.lower()), None)
                if target_key:
                    orig_pins = original_subckts_dict[target_key].pins
                    mapped_ports = []
                    for idx, net in enumerate(inst.nets):
                        if idx < len(orig_pins):
                            mapped_ports.append(f".{orig_pins[idx]}({net})")
                        else:
                            mapped_ports.append(f".extra_pin_{idx}({net})")
                            
                    target_clean = target_key.lower().replace(top_module_name.lower(), "").replace("tsmc65n", "").strip("_")
                    
                    if target_clean == 'capped_replica_bitcell_array':
                        gnd_net = "gnd"
                        vdd_net = "vdd"
                        if "gnd" in orig_pins: gnd_net = inst.nets[orig_pins.index("gnd")]
                        if "vdd" in orig_pins: vdd_net = inst.nets[orig_pins.index("vdd")]

                        for dwl in (dummy_wl_pins + dummy_bl_pins + dummy_br_pins):
                            mapped_ports.append(f".{dwl}({gnd_net})")
                        for vpin in vdd_pins:
                            mapped_ports.append(f".{vpin}({vdd_net})")
                        for gpin in gnd_pins:
                            mapped_ports.append(f".{gpin}({gnd_net})")
                            
                    verilog_lines.append(f"  {inst.cell_type} {inst.name} ({', '.join(mapped_ports)});")
                else:
                    mapped_ports = [f".pin_{i}({n})" for i, n in enumerate(inst.nets)]
                    verilog_lines.append(f"  {inst.cell_type} {inst.name} ({', '.join(mapped_ports)});")
                
        verilog_lines.append("endmodule\n")
    return "\n".join(verilog_lines)

def main():
    if len(sys.argv) < 2 or sys.argv[1] in ['-h', '--help']:
        print("Uso: python spice_to_structural_verilog.py <arquivo_spice.sp>")
        sys.exit(1)
        
    spice_path = sys.argv[1]
    verilog_path = os.path.splitext(spice_path)[0] + ".v"
    
    print(f"[TSMC65N] Lendo netlist: {spice_path} ...")
    with open(spice_path, 'r') as f:
        raw_lines = f.readlines()
        
    cleaned_spice = preprocess_spice(raw_lines)
    original_subckts_dict = parse_spice(cleaned_spice)
    subckts = parse_spice(cleaned_spice)
    
    top_module_name = os.path.splitext(os.path.basename(spice_path))[0]
    if top_module_name not in subckts:
        possible_tops = [k for k in subckts.keys() if not any(k.lower().endswith(m.lower()) for m in MACRO_BLACKBOXES + SUB_HIERARCHIES_TO_IGNORE)]
        if possible_tops:
            top_module_name = possible_tops[0]

    print(f"[TSMC65N] Nome do bloco Top detectado: {top_module_name}")
    print("[TSMC65N] Executando Achatamento (Flatten) seletivo...")
    flatten_netlist(subckts, top_module_name)
    
    print("[TSMC65N] Gerando Verilog Estrutural com amarrações...")
    verilog_output = write_verilog(subckts, top_module_name, original_subckts_dict)
    
    final_output = f"""// Verilog Estrutural Gerado Automaticamente (TSMC 65nm)
// Origem: {spice_path}

`timescale 1ns/1ps
{verilog_output}
"""

    with open(verilog_path, 'w') as f:
        f.write(final_output)
    print(f"[TSMC65N] Concluído com sucesso em: {verilog_path}")

if __name__ == "__main__":
    main()
