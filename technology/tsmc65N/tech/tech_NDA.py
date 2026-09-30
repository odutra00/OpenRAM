# See LICENSE for licensing information.
#
# Copyright (c) 2016-2023 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
import os
import sys
from openram import drc as d

"""
Process technology parameters for TSMC 65nm (tsmc65N).
"""

###################################################
# Custom modules
###################################################

# Instancia a estrutura de dados interna do OpenRAM para mapear módulos.
# Mais adiante, usaremos este dicionário 'tech_modules' para forçar o OpenRAM
# a usar seus scripts de wrapper (pinv, pnand2, etc.) em vez dos geradores automáticos.
#tech_modules = d.module_type()
# ----------------------------------------------------------------------
# 1. Adiciona a pasta de módulos da TSMC 65nm no PATH do Python
# ----------------------------------------------------------------------
tech_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
modules_dir = os.path.join(tech_dir, "custom")

if modules_dir not in sys.path:
    sys.path.insert(0, modules_dir)
###################################################
# Mapeamento de Módulos Customizados (TSMC 65nm)
###################################################
# Configura o dicionário de módulos caso ainda não exista
if not hasattr(d, "module_type"):
    tech_modules = {}
else:
    tech_modules = d.module_type()

# Habilita o uso de células Hard-Macro (GDS estáticos)
has_precharge = True
has_dff = True
has_inv = True
has_nand2 = True
has_and2 = True
has_and3 = True

# Mapeia os nomes EXATOS dos arquivos contidos na sua pasta gds_lib/ (sem a extensão .gds)
precharge_cell = "precharge"   
inv_cell = "pinv"
nand2_cell = "pnand2"
and2_cell = "pand2"
and3_cell = "pand3"
dff_cell = "dff"
sense_amp_cell = "sense_amp"
write_driver_cell = "write_driver"
bitcell = "cell_1rw"
dummy_bitcell = "dummy_cell_1rw"
replica_bitcell = "replica_cell_1rw"


# 1. Informa ao OpenRAM para usar a sua classe em vez da procedural
tech_modules["precharge"] = "precharge"
tech_modules["precharge_array"] = "precharge_array"
tech_modules["pinv"] = "pinv"
tech_modules["pnand2"] = "pnand2"
tech_modules["pand2"] = "pand2"
tech_modules["pand3"] = "pand3"

# ==============================================================================
# Override default OpenRAM modules to tsmc65N custom modules
# ==============================================================================
# Mapeia as suas classes estruturais customizadas da pasta custom/
tech_modules["bitcell_array"] = ["tsmc65N_bitcell_array", "bitcell_array"]
tech_modules["capped_replica_bitcell_array"] = ["tsmc65N_capped_replica_bitcell_array", "capped_replica_bitcell_array"]
tech_modules["dummy_array"] = ["tsmc65N_dummy_array", "dummy_array"]
tech_modules["replica_column"] = ["tsmc65N_replica_column", "replica_column"]
tech_modules["bitcell_base_array"] = ["tsmc65N_bitcell_base_array", "bitcell_base_array"]
tech_modules["sense_amp_array"] = ["tsmc65N_sense_amp_array", "sense_amp_array"]
tech_modules["precharge_array"] = ["tsmc65N_precharge_array", "precharge_array"]
tech_modules["write_driver_array"] = ["tsmc65N_write_driver_array", "write_driver_array"]

###################################################
# Custom cell properties
###################################################
cell_properties = d.cell_properties()
###################### Precharge #################################################
# 1. Instancia a célula precharge informando portas, tipos e mapa
cell_properties.precharge = d.cell(
    ['bl', 'br', 'en_bar', 'vdd'],                 # Ordem das portas
    ['OUTPUT', 'OUTPUT', 'INPUT', 'POWER'],        # Tipos das portas
    {'bl': 'bl', 'br': 'br', 'en_bar': 'en_bar', 'vdd': 'vdd'} # Mapeamento
)
# 2. Registra o nome do arquivo GDS/SPICE
cell_properties.names["precharge"] = "precharge"
# 3. Informa as camadas de roteamento do layout
cell_properties.precharge.bl_layer = "m2"
cell_properties.precharge.br_layer = "m2"
cell_properties.precharge.en_layer = "m1"
cell_properties.precharge.vdd_layer = "m1"


##############inv#################################
cell_properties.inv = d.cell(
    ['A', 'Z', 'vdd', 'gnd'],
    ['INPUT', 'OUTPUT', 'POWER', 'GROUND'],
    {
        'A': 'A',
        'Z': 'Z',
        'vdd': 'vdd',
        'gnd': 'gnd'
    }
)
# 2. Registra o nome do arquivo GDS/SPICE
cell_properties.names["inv"] = "pinv"
# 3. Informa as camadas de roteamento do layout
cell_properties.inv.Z_layer = "m1"
cell_properties.inv.A_layer = "m1"
cell_properties.inv.gnd_layer = "m1"
cell_properties.inv.vdd_layer = "m1"

cell_properties.inv.vdd_dir = "H"
cell_properties.inv.gnd_dir = "H"
cell_properties.inv.A_dir = "H"
cell_properties.inv.Z_dir = "V"


#######################NAND2################################
cell_properties.nand2 = d.cell(
    ['A', 'B', 'Z', 'vdd', 'gnd'],
    ['INPUT', 'INPUT', 'OUTPUT', 'POWER', 'GROUND'],
    {
        'A': 'A',
        'B': 'B',
        'Z': 'Z',
        'vdd': 'vdd',
        'gnd': 'gnd'
    }
)
# 2. Registra o nome do arquivo GDS/SPICE
cell_properties.names["nand2"] = "pnand2"

# 3. Informa as camadas de roteamento do layout
cell_properties.nand2.A_layer = "m2"
cell_properties.nand2.B_layer = "m2"
cell_properties.nand2.Z_layer = "m2"
cell_properties.nand2.gnd_layer = "m1"
cell_properties.nand2.vdd_layer = "m1"

cell_properties.nand2.vdd_dir = "H"
cell_properties.nand2.gnd_dir = "H"
cell_properties.nand2.A_dir = "H"
cell_properties.nand2.B_dir = "H"
cell_properties.nand2.Z_dir = "V"


#######################AND2################################
cell_properties.and2 = d.cell(
    ['A', 'B', 'Z', 'vdd', 'gnd'],
    ['INPUT', 'INPUT', 'OUTPUT', 'POWER', 'GROUND'],
    {
        'A': 'A',
        'B': 'B',
        'Z': 'Z',
        'vdd': 'vdd',
        'gnd': 'gnd'
    }
)
# 2. Registra o nome do arquivo GDS/SPICE
cell_properties.names["and2"] = "pand2"

# 3. Informa as camadas de roteamento do layout
cell_properties.and2.A_layer = "m2"
cell_properties.and2.B_layer = "m2"
cell_properties.and2.Z_layer = "m2"
cell_properties.and2.gnd_layer = "m1"
cell_properties.and2.vdd_layer = "m1"

cell_properties.and2.vdd_dir = "H"
cell_properties.and2.gnd_dir = "H"
cell_properties.and2.A_dir = "V"
cell_properties.and2.B_dir = "V"
cell_properties.and2.Z_dir = "V"



#######################AND3################################
cell_properties.and3 = d.cell(
    ['A', 'B', 'C', 'Z', 'vdd', 'gnd'],
    ['INPUT', 'INPUT', 'INPUT', 'OUTPUT', 'POWER', 'GROUND'],
    {
        'A': 'A',
        'B': 'B',
        'C': 'C',
        'Z': 'Z',
        'vdd': 'vdd',
        'gnd': 'gnd'
    }
)
# 2. Registra o nome do arquivo GDS/SPICE
cell_properties.names["and3"] = "pand3"

# 3. Informa as camadas de roteamento do layout
cell_properties.and3.A_layer = "m2"
cell_properties.and3.B_layer = "m2"
cell_properties.and3.C_layer = "m2"
cell_properties.and3.Z_layer = "m2"
cell_properties.and3.gnd_layer = "m1"
cell_properties.and3.vdd_layer = "m1"

cell_properties.and3.vdd_dir = "H"
cell_properties.and3.gnd_dir = "H"
cell_properties.and3.A_dir = "V"
cell_properties.and3.B_dir = "V"
cell_properties.and3.C_dir = "V"
cell_properties.and3.Z_dir = "V"


###################################################
# Custom layer properties
###################################################
# Armazena propriedades especiais de camadas (como vias de grade ou direções de roteamento preferenciais).
layer_properties = d.layer_properties()

###################################################
# GDS file info
###################################################

GDS = {}

# UNIDADES DO GDS:
# O padrão industrial para PDKs comerciais (incluindo TSMC 65nm) usa:
# 1 dbu (database unit) = 1 nm = 1e-9 m.
# Como a unidade do usuário no GDS normalmente é 1 um (1e-6 m), a proporção é 1000 dbu / um.
# Portanto, o primeiro parâmetro é 0.001 (1 / 1000) e o segundo é 1e-9.
# No FreePDK45 usava-se 0.0005 (grid de 0.5nm), mas na TSMC 65nm o grid base é 1nm / 5nm (0.001, 1e-9).
GDS["unit"] = (0.001, 1e-9)

# Nível de zoom padrão para visualização/debug de labels em ferramentas de visualização GDS.
GDS["zoom"] = 0.05




###################################################
# Power Grid DefinitionInterconnect stacks
###################################################
# Define a camada e as larguras dos trilhos de alimentação das células
power_grid_layer = "m1"
top_power_grid_layer = "m1"  # Se não for usar straps verticais em M2/M3

# Definição dos trilhos de VDD/VSS das células lógicas em M1
supply_rails = ["m1"]

# Largura padrão do rail de VDD/VSS em M1
power_rail_width = 0.20  # Ajuste para a largura exata do seu rail de M1 em microns

# Nomes globais de alimentação reconhecidos pelo compilador
vdd_name = "vdd"
vss_name = "vss"




###################################################
# Interconnect stacks
###################################################

# Definição das pilhas de conexão (Layer Inferior, Via/Contato, Layer Superior)
poly_stack = ("poly", "contact", "m1")
active_stack = ("active", "contact", "m1")
m1_stack = ("m1", "via1", "m2")
m2_stack = ("m2", "via2", "m3")
m3_stack = ("m3", "via3", "m4")

# Removido m3_stack (m3, via3, m4) para limitar o roteamento até Metal 3

# Suporte a ROM (desativado no seu config, mas mantido em ordem lógica até m3)
lef_rom_interconnect = ["m1", "m2", "m3", "m4"]

# Índice das camadas de roteamento (usado pelo roteador de sinal/power do OpenRAM)
layer_indices = {
    "poly": 0,
    "active": 0,
    "m1": 1,
    "m2": 2,
    "m3": 3,
    "m4": 4
}

# Pilhas FEOL (Front-End of Line - conectam transistores/polissilício ao Metal 1)
feol_stacks = [
    poly_stack,
    active_stack
]

# Pilhas BEOL (Back-End of Line - conexões entre metais de M1 a M3)
beol_stacks = [
    m1_stack,
    m2_stack,
    m3_stack
]

layer_stacks = feol_stacks + beol_stacks

# Direção preferencial de roteamento (M1 Horizontal, M2 Vertical, M3 Horizontal)
# Essencial para o Roteador de Canal e Roteador de Sinal (Maze Router) evitar curtocircuitos
preferred_directions = {
    "poly": "V",
    "active": "V",
    "m1": "H",
    "m2": "H",
    "m3": "H",
    "m4": "V"
}









###################################################
# Power grid
###################################################
# Use M3/M4


###################################################
# GDS Layer Map & Purpose Definitions
###################################################

use_purpose = False #{}
has_purpose = False

# Layer names for external PDKs
layer_names = {}
layer_names["vtg"]      = "NAME_LAYER_YOUR_PDK" 
layer_names["vth"]      = "NAME_LAYER_YOUR_PDK"
layer_names["thkox"]    = "NAME_LAYER_YOUR_PDK"
layer_names["active"]   = "NAME_LAYER_YOUR_PDK"
layer_names["pwell"]    = "NAME_LAYER_YOUR_PDK"
layer_names["nwell"]    = "NAME_LAYER_YOUR_PDK"
layer_names["nimplant"] = "NAME_LAYER_YOUR_PDK"
layer_names["pimplant"] = "NAME_LAYER_YOUR_PDK"
layer_names["poly"]     = "NAME_LAYER_YOUR_PDK"
layer_names["contact"]  = "NAME_LAYER_YOUR_PDK"
layer_names["m1"]       = "NAME_LAYER_YOUR_PDK"
layer_names["via1"]     = "NAME_LAYER_YOUR_PDK"
layer_names["m2"]       = "NAME_LAYER_YOUR_PDK"
layer_names["via2"]     = "NAME_LAYER_YOUR_PDK"
layer_names["m3"]       = "NAME_LAYER_YOUR_PDK"
layer_names["via3"]     = "NAME_LAYER_YOUR_PDK"
layer_names["m4"]       = "NAME_LAYER_YOUR_PDK"
layer_names["via4"]     = "NAME_LAYER_YOUR_PDK"
layer_names["m5"]       = "NAME_LAYER_YOUR_PDK"
layer_names["via5"]     = "NAME_LAYER_YOUR_PDK"
layer_names["m6"]       = "NAME_LAYER_YOUR_PDK"
layer_names["via6"]     = "NAME_LAYER_YOUR_PDK"
layer_names["text"]     = "NAME_LAYER_YOUR_PDK"
layer_names["boundary"] = "NAME_LAYER_YOUR_PDK"


# Camadas de Geometria/Desenho (Drawing / Net)
layer = {}
layer["nwell"]       = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["pwell"]       = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["active"]      = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["nimplant"]    = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["pimplant"]    = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["vtg"]         = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["vth"]         = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["thkox"]       = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["poly"]        = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["contact"]     = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)

layer["m1"]          = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["via1"]        = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["m2"]          = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["via2"]        = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["m3"]          = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["via3"]        = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["m4"]          = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["via4"]        = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["m5"]          = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["via5"]        = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["m6"]          = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)
layer["via6"]        = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)

layer["boundary"]    = (LAYER_YOUR_PDK, PURPOSE_YOUR_PDK)

layer_pin = layer #apenas pq os gds estãoa gora como M* drawing
layer_label = layer


###################################################
# DRC/LVS Rules Setup
###################################################

#technology parameter
parameter={}
parameter["min_tx_size"] = RULE_YOUR_PDK
parameter["beta"] = 1.51 #3 #cell ratio (beta) = Wdriver(inv_nmos) / Waccess
parameter["6T_inv_nmos_size"] = 0.205
parameter["6T_inv_pmos_size"] = 0.12 #0.09
parameter["6T_access_size"] = 0.135 #width chave de passagem

drclvs_home=os.environ.get("DRCLVS_HOME")


"""
OpenRAM Technology Setup File
Regras de DRC convertidas do PDK para OpenRAM
"""
drc = d.design_rules("tsmc65")

#grid size
drc["grid"] = 0.005 #0.0025

#DRC/LVS test set_up - TODO rodar manualmente depois
#drc["drc_rules"]=drclvs_home + "/calibreDRC.rul"
#drc["lvs_rules"]=drclvs_home + "/calibreLVS.rul"
#drc["xrc_rules"]=drclvs_home + "/calibrexRC.rul"
#drc["layer_map"]=os.environ.get("OPENRAM_TECH") + "/freepdk45/layers.map"

# =========================================================
# DRC FEOL - TSMC 65nm (Ajustado para o Layout Procedural)
# =========================================================

#From now on, the values are ficticious. They will not interfer in the memory
#as we are not using parametrized digital/analog cells (readme README.md)

# =============================================================================
# 1. ACTIVE / DIFFUSION (OD)
# =============================================================================
drc["minwidth_active"]         = 0.10   # OD.W.1: Largura mínima de OD
drc["active_to_active"]        = 0.13   # OD.S.1: Espaçamento mínimo entre ODs
drc["minarea_active"]          = 0.010  # OD.A.1: Área mínima de OD (um²)

# Transistores I/O / High Voltage (se aplicável)
drc["minwidth_active_io"]      = 0.50   # OD.W.3: Largura mínima para I/O (Core=0.12)

# =============================================================================
# 2. WELLS (N-WELL & P-WELL) - Chaves Obrigatórias do OpenRAM
# =============================================================================
# Larguras
drc["minwidth_nwell"]           = 0.5
drc["minwidth_pwell"]           = 0.5
drc["minwidth_well"]            = 0.5

# Espaçamentos
drc["nwell_to_nwell"]               = 0.5
drc["pwell_to_pwell"]               = 0.5
drc["well_to_well"]                 = 0.5
drc["pwell_to_nwell"]               = 0.5   
drc["nwell_to_pwell"]               = 0.5   # Alias de prevenção
drc["nwell_to_nwell_diff_potential"] = 1.05

# Extensões / Enclosures de OD no Poço (Resolve o KeyError 'pwell_enclose_active')
drc["well_extend_active"]       = 0.2
drc["nwell_extend_active"]      = 0.2
drc["pwell_extend_active"]      = 0.2
drc["nwell_enclose_active"]     = 0.2
drc["pwell_enclose_active"]     = 0.2   
drc["nwell_enclosure_active"]   = 0.2
drc["pwell_enclosure_active"]   = 0.2

# Distâncias da borda do poço para difusão
drc["active_to_nwell"]          = 0.2
drc["active_to_pwell"]          = 0.2
drc["active_to_well_edge"]      = 0.2
drc["active_to_body_tap"]       = 0.2

# =============================================================================
# 3. POLY / GATE (PO)
# =============================================================================
drc["minwidth_poly"]           = 0.1    # PO.W.1: Largura/Comprimento mínimo de canal (Lmin)
drc["poly_to_poly"]            = 0.15   # PO.S.1: Espaçamento entre Poly em campo
drc["poly_to_poly_same_active"] = 0.15  # PO.S.2: Espaçamento de Poly/Gate na mesma difusão
drc["poly_to_active"]          = 0.15   # PO.S.4: Espaçamento Poly em campo para OD
drc["poly_extend_active"]      = 0.15   # PO.EX.1: Extensão do Poly além do OD (End-cap)
drc["active_extend_poly"]      = 0.15   # PO.EX.2: Extensão da difusão além do Poly
drc["minarea_poly"]            = 0.010  # PO.A.1: Área mínima de Poly (um²)

# Geometria Transistor & Canal
drc["minwidth_tx"] = 0.2           # Largura minima de canal W (150nm evita dog-bones)
drc["minlength_channel"] = 0.10     # Comprimento nominal do canal L 

# Transistores High-Voltage / I/O
drc["minwidth_poly_18v"]       = 0.30   # PO.W.4: Canal de 1.8V
drc["minwidth_poly_25v"]       = 0.40   # PO.W.2: Canal de 2.5V
drc["minwidth_poly_33v"]       = 0.40   # PO.W.3: Canal de 3.3V

# =============================================================================
# 4. CONTACT / VIA0 (CO) & ENCLOSURES / EXTENSIONS
# =============================================================================
drc["minwidth_contact"]          = 0.10
drc["contact_to_contact"]        = 0.12
drc["contact_to_contact_diff_net"] = 0.15

# Active Enclosure/Extend Contact
drc["active_enclose_contact"]    = 0.020
drc["active_enclosure_contact"]  = 0.020
drc["active_extend_contact"]     = 0.020

# Poly Enclosure/Extend Contact 
drc["poly_enclose_contact"]      = 0.05
drc["poly_enclosure_contact"]    = 0.05
drc["poly_extend_contact"]       = 0.05  

# Well Enclosure/Extend Contact
drc["nwell_enclose_contact"]     = 0.05
drc["nwell_enclosure_contact"]   = 0.05
drc["pwell_enclose_contact"]     = 0.05
drc["pwell_enclosure_contact"]   = 0.05

# Espaçamentos de Contato
drc["contact_to_poly"]           = 0.07
drc["poly_to_contact"]           = 0.07
drc["active_contact_to_gate"]    = 0.07
drc["poly_contact_to_active"]    = 0.07
drc["poly_contact_to_gate"]      = 0.07
drc["poly_contact_to_poly"]      = 0.10


# =============================================================================
# IMPLANT (NIMP / PIMP) - REGRAS REAIS TSMC 65nm
# =============================================================================

# IMP.1: Largura mínima de NIMP / PIMP
drc["minwidth_implant"]          = 0.2   # Minimum width of NIMP/PIMP

# IMP.2: Espaçamento mínimo entre Implantes (NIMP-to-NIMP / PIMP-to-PIMP)
drc["implant_to_implant"]        = 0.2   # Minimum spacing of NIMP/PIMP

# IMP.3a: Enclosure de Implante sobre Active/OD (Overhang)
drc["implant_enclose_active"]    = 0.10   # NIMP/PIMP overlap of OD (End-of-Active)
drc["implant_extend_active"]     = 0.10   # Alias de extensão

# IMP.3b: Espaçamento de Implante para Active/OD de tipo oposto
drc["implant_to_active"]         = 0.10   # Space from NIMP to P+ OD (or PIMP to N+ OD)

# IMP.4: Enclosure de Implante sobre Contato de Tap (CO)
drc["implant_enclose_contact"]   = 0.05   # NIMP/PIMP overlap of Contact on Tap

# =============================================================================
# ALIASES DE COMPATIBILIDADE PARA O OPENRAM
# =============================================================================
drc["nimplant_enclose_active"]  = drc["implant_enclose_active"]
drc["pimplant_enclose_active"]  = drc["implant_enclose_active"]
drc["nimplant_to_pimplant"]      = drc["implant_to_implant"]
drc["minarea_implant"]           = 0.010  












# -------------------------------------------------------------------
# METAL 1
# -------------------------------------------------------------------
drc.add_layer(
    "m1",
    width=0.09,                     # M1.W.1
    spacing=d.drc_lut({             # M1.S.1 ate M1.S.4 (Wide Metal Spacing)
        (0.00, 0.00): 0.10,         # Standard Spacing (M1.S.1)
        (0.20, 0.38): 0.13,         # M1.S.2  
    }),
)
drc["m1_to_m1"] = 0.15 
drc["minarea_m1"] = 0.010 # M1.A.1 

# Enclosure de M1 sobre CONTACT (CO)
# M1.EN.3 
drc.add_enclosure(
    "m1",
    layer="contact",
    enclosure=0.10, 
    extension=0.040

# -------------------------------------------------------------------
# VIA 1
# -------------------------------------------------------------------
drc.add_layer(
    "via1",
    width=0.11,                     # Tamanho padrão de Via 1 na TSMC65
    spacing=0.11                    # Spacing Via1-to-Via1 
)

# Enclosure de M1 sobre VIA1
drc.add_enclosure(
    "m1",
    layer="via1",
    enclosure=0.08, 5 # M1_EN_3 
    extension=0.050   # Extensao recomendada para vias de final de linha
)





# -------------------------------------------------------------------
# METAL 2
# -------------------------------------------------------------------
drc.add_layer(
    "m2",
    width=0.10,                     # M2.W.1 
    spacing=d.drc_lut({             # M2.S.1 ate M2.S.4 (Wide Metal Spacing)
        (0.00, 0.00): 0.15,         # Standard Spacing (M2.S.1)
        (0.20, 0.38): 0.15,         # M2.S.2   
    }),
)

drc["minarea_m2"] = 0.005 # M2.A.1 

# Enclosure de M2 sobre VIA1 
drc.add_enclosure(
    "m2",
    layer="via1",
    enclosure=0.10, 
    extension=0.050   # M2_EN_2 
)

# Enclosure de M2 sobre VIA2
drc.add_enclosure(
    "m2",
    layer="via2",
    enclosure=0.10, 
    extension=0.050               
)

# -------------------------------------------------------------------
# VIA 2
# -------------------------------------------------------------------
drc.add_layer(
    "via2",
    width=0.20,     
    spacing=0.20  
)





# -------------------------------------------------------------------
# METAL 3
# -------------------------------------------------------------------
drc.add_layer(
    "m3",
    width=0.10,                     # M3.W.1 
    spacing=d.drc_lut({             # M3.S.1 ate M3.S.4 (Wide Metal Spacing)
        (0.00, 0.00): 0.20,         # Standard Spacing (M3.S.1)
        (0.20, 0.38): 0.25,         # M3.S.2  
    }),
)

drc["minarea_m3"] = 0.005 # M3.A.1

# Enclosure de M3 sobre VIA2 
drc.add_enclosure(
    "m3",
    layer="via2",
    enclosure=0.16, # M3_EN_3 
    extension=0.050 # M3_EN_2  (opposite sides/extension)
)

# Enclosure de M3 sobre VIA3
drc.add_enclosure(
    "m3",
    layer="via3",
    enclosure=0.16, 
    extension=0.050 
)

# -------------------------------------------------------------------
# VIA 3
# -------------------------------------------------------------------
drc.add_layer(
    "via3",
    width=0.20,                     # Tamanho padrao de Via 3 
    spacing=0.20                    # Spacing Via3-to-Via3 
)






# -------------------------------------------------------------------
# METAL 4
# -------------------------------------------------------------------
drc.add_layer(
    "m4",
    width=0.20,                     # M4.W.1 
    spacing=d.drc_lut({             # M4.S.1 ate M4.S.4 (Wide Metal Spacing)
        (0.00, 0.00): 0.20,         # Standard Spacing (M4.S.1)
        (0.20, 0.38): 0.22,         # M4.S.2  
    }),
)

drc["minarea_m4"] = 0.015  # M4.A.1 1

# Enclosure de M4 sobre VIA3 
drc.add_enclosure(
    "m4",
    layer="via3",
    enclosure=0.040,                # M4_EN_3
    extension=0.050                 # M4_EN_2
)

# Enclosure de M4 sobre VIA4
drc.add_enclosure(
    "m4",
    layer="via4",
    enclosure=0.040,                # Segue o mesmo padrao M4.EN.3 
    extension=0.050                 # Segue a extensão de fim de linha 
)

# -------------------------------------------------------------------
# VIA 4
# -------------------------------------------------------------------
drc.add_layer(
    "via4",
    width=0.20,                     # Tamanho padrao de Via 4 
    spacing=0.20                    # Spacing Via4-to-Via4 
)





# -------------------------------------------------------------------
# METAL 5
# -------------------------------------------------------------------
drc.add_layer(
    "m5",
    width=0.15,                     # M5.W.1 
    spacing=d.drc_lut({             # M5.S.1 ate M5.S.4 (Wide Metal Spacing)
        (0.00, 0.00): 0.15,         # Standard Spacing (M5.S.1)
        (0.20, 0.38): 0.15,         # M5.S.2  
    }),
)

drc["minarea_m5"] = 0.010 # M5.A.1 

# Enclosure de M5 sobre VIA4 
drc.add_enclosure(
    "m5",
    layer="via4",
    enclosure=0.040,                # M5_EN_3
    extension=0.050                 # M5_EN_2 
)

# Enclosure de M5 sobre VIA5 (se a tecnologia utilizar M6/Via5 acima)
drc.add_enclosure(
    "m5",
    layer="via5",
    enclosure=0.050,                # Segue o mesmo padrao M5.EN.3 
    extension=0.050                 # Segue a extensão de fim de linha
)

# -------------------------------------------------------------------
# VIA 5
# -------------------------------------------------------------------
drc.add_layer(
    "via5",
    width=0.20,                     # Tamanho padrao de Via 5
    spacing=0.20                    # Spacing Via5-to-Via5
)


















###################################################
# Spice Simulation Parameters (Dummy Setup para Layout)
###################################################

spice = {}
spice["nmos"] = "nch"
spice["pmos"] = "pch"

spice["supply_voltages"] = [0.9, 1.0, 1.1, 1.2]  # Tensão nominal e variações (Volts)
spice["nom_supply_voltage"] = 1.0                # Tensão nominal padrão
spice["rise_time"] = 0.05                         # Tempo de subida dos sinais (ns)
spice["fall_time"] = 0.05                         # Tempo de descida dos sinais (ns)
spice["temperatures"] = [0, 25, 125]             # Faixas de temperatura (Celsius)
spice["nom_temperature"] = 25                     # Temperatura nominal

# Modelos estáticos desativados durante a fase de geração de Layout
spice["fet_models"] = {
    "TT": []
}

# SPICE_MODEL_DIR desativado temporariamente
SPICE_MODEL_DIR = os.environ.get("SPICE_MODEL_DIR", "")

spice["feasible_period"] = 10      # Período estimado em ns
spice["supply_voltage"] = 1.2      # Tensão nominal TSMC 65nm
spice["min_period"] = 1.0

# analytical delay parameters
spice["nom_threshold"] = 0.4     # Typical Threshold voltage in Volts
spice["wire_unit_r"] = 0.25      # Unit wire resistance in ohms/square
spice["wire_unit_c"] = 2.3e-15   # Unit wire capacitance F/um^2, calculated from PTM
spice["min_tx_drain_c"] = 0.7    # Minimum transistor drain capacitance in ff
spice["min_tx_gate_c"] = 0.2     # Minimum transistor gate capacitance in ff
spice["dff_setup"] = 9        # DFF setup time in ps
spice["dff_hold"] = 1         # DFF hold time in ps
spice["dff_in_cap"] = 0.005  # Input capacitance (D) [Femto-farad]
spice["dff_out_cap"] = 0.005       # Output capacitance (Q) [Femto-farad]

spice["default_event_frequency"] = 100     # Default event activity of every gate. MHz


# Define se usará modelo analítico
analytical_delay = True

# No seu $OPENRAM_TECH/tech.py

parameter={}
parameter["min_tx_size"] = 0.06 #0.09
parameter["beta"] = 1.51 #3 #cell ratio (beta) = Wdriver(inv_nmos) / Waccess
parameter["6T_inv_nmos_size"] = 0.205
parameter["6T_inv_pmos_size"] = 0.12 #0.09
parameter["6T_access_size"] = 0.135 #width chave de passagem
parameter["min_inv_para_delay"] = 1.0   # Parasitic delay of a minimum inverter
parameter["tau"] = 0.005                # RC time constant tau (em nanosegundos / ps)

# Se o seu tech.py usar o dicionário spice ou tech para o tau:
spice["tau"] = 0.005
# Parameters related to sense amp enable timing and delay chain/RBL sizing
parameter["le_tau"] = 2.25                  # In pico-seconds.
parameter["cap_relative_per_ff"] = 7.5      # Units of Relative Capacitance/ Femto-Farad
parameter["dff_clk_cin"] = 30.6             # relative capacitance
parameter["6tcell_wl_cin"] = 3              # relative capacitance
parameter["min_inv_para_delay"] = 2.4       # Tau delay units
parameter["sa_en_pmos_size"] = 0.72         # micro-meters
parameter["sa_en_nmos_size"] = 0.27         # micro-meters
parameter["sa_inv_pmos_size"] = 0.54        # micro-meters
parameter["sa_inv_nmos_size"] = 0.27        # micro-meters
parameter["bitcell_drain_cap"] = 0.1        # In Femto-Farad, approximation of drain capacitance


###################################################
# DRC & Verification Engine Settings
###################################################

# Nome do motor de DRC padrão (geralmente 'calibre', 'pvs' ou 'magic')
drc_name = "pvs" 
lvs_name = "pvs"
pex_name = "pvs"
# Regra de DRC para o OpenRAM saber se deve ou não rodar DRC automaticamente
# Opções comuns: "calibre", "pvs", "magic", "freepdk45"
drc_exe = "pvs"
lvs_exe = "pvs"

# Flag para indicar se a tecnologia possui regras de verificação ativas
has_drc = False
has_lvs = False

# Desativa execução de simulações caracterizadas durante o build
characterize = False
simulation = False



