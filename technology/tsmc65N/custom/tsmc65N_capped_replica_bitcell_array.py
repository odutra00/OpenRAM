# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California, Santa Cruz
# All rights reserved.
#
#TODO a celula dummy do canto interior direito tem os pinos BL e BR shiftados para a direita. lembrar de corrigir na mao ou arrumar o codigo

from openram import debug
from openram.base import vector
from openram.base import contact
from openram.base import design
from openram.sram_factory import factory
from openram.tech import drc, spice
from openram.tech import cell_properties as props
from openram import OPTS
#from .bitcell_base_array import bitcell_base_array
from .tsmc65N_bitcell_base_array import tsmc65N_bitcell_base_array

#Modificado Por Odilon para geraçao do lef dos modulos flattened
from openram.base import lef

class tsmc65N_capped_replica_bitcell_array(tsmc65N_bitcell_base_array, lef):
    """
    Creates a replica bitcell array then adds the row and column caps to all
    sides of a bitcell array.
    """
    def __init__(self, rows, cols, rbl=None, left_rbl=None, right_rbl=None, name=""):
        super().__init__(name, rows, cols, column_offset=0)
        #Modificado por Odilon para geracao do lef nos arrays flattened
        design.__init__(self, name)
        lef.__init__(self, ["m1", "m2", "m3", "m4"])
        #Modificado por Odilon
        debug.info(1, "Creating {0} {1} x {2} rbls: {3} left_rbl: {4} right_rbl: {5}".format(self.name,
                                                                                             rows,
                                                                                             cols,
                                                                                             rbl,
                                                                                             left_rbl,
                                                                                             right_rbl))
        self.add_comment("rows: {0} cols: {1}".format(rows, cols))
        self.add_comment("rbl: {0} left_rbl: {1} right_rbl: {2}".format(rbl, left_rbl, right_rbl))

        self.column_size = cols
        self.row_size = rows
        # This is how many RBLs are in all the arrays
        if rbl is not None:
            self.rbl = rbl
        else:
            self.rbl = [0] * len(self.all_ports)
        # This specifies which RBL to put on the left or right by port number
        # This could be an empty list
        if left_rbl is not None:
            self.left_rbl = left_rbl
        else:
            self.left_rbl = []
        # This could be an empty list
        if right_rbl is not None:
            self.right_rbl = right_rbl
        else:
            self.right_rbl=[]
        self.rbls = self.left_rbl + self.right_rbl

        # Two dummy rows plus replica even if we don't add the column
        self.extra_rows = sum(self.rbl)
        # If we aren't using row/col caps, then we need to use the bitcell
        if not self.cell.end_caps:
            self.extra_rows += 2

        self.create_netlist()
        if not OPTS.netlist_only:
            self.create_layout()

    def create_netlist(self):
        """ Create and connect the netlist """
        self.add_modules()
        self.add_pins()
        self.create_instances()

    def add_modules(self):
        """  Array and cap rows/columns """

        self.replica_bitcell_array = factory.create(module_type="replica_bitcell_array",
                                                    cols=self.column_size,
                                                    rows=self.row_size,
                                                    rbl=self.rbl,
                                                    left_rbl=self.left_rbl,
                                                    right_rbl=self.right_rbl)

        # Dummy Row or Col Cap, depending on bitcell array properties
        col_cap_module_type = ("col_cap_array" if self.cell.end_caps else "dummy_array")

        # TODO: remove redundancy from arguments in pairs below (top/bottom, left/right)
        # for example, cols takes the same value for top/bottom
        self.col_cap_top = factory.create(module_type=col_cap_module_type,
                                          cols=self.column_size + len(self.rbls),
                                          rows=1,
                                          # dummy column + left replica column(s)
                                          column_offset=1,
                                          mirror=0,
                                          location="top")

        self.col_cap_bottom = factory.create(module_type=col_cap_module_type,
                                             cols=self.column_size + len(self.rbls),
                                             rows=1,
                                             # dummy column + left replica column(s)
                                             column_offset=1,
                                             mirror=0,
                                             location="bottom")

        # Dummy Col or Row Cap, depending on bitcell array properties
        row_cap_module_type = ("row_cap_array" if self.cell.end_caps else "dummy_array")

        self.row_cap_left = factory.create(module_type=row_cap_module_type,
                                            cols=1,
                                            column_offset=0,
                                            rows=self.row_size + self.extra_rows,
                                            mirror=(self.rbl[0] + 1) % 2)

        self.row_cap_right = factory.create(module_type=row_cap_module_type,
                                            cols=1,
                                            #   dummy column
                                            # + left replica column(s)
                                            # + bitcell columns
                                            # + right replica column(s)
                                            column_offset=1 + len(self.left_rbl) + self.column_size + self.rbl[0],
                                            rows=self.row_size + self.extra_rows,
                                            mirror=(self.rbl[0] + 1) % 2)

    def add_pins(self):

        # Arrays are always:
        # bitlines (column first then port order)
        # word lines (row first then port order)
        # dummy wordlines
        # replica wordlines
        # regular wordlines (bottom to top)
        # # dummy bitlines
        # replica bitlines (port order)
        # regular bitlines (left to right port order)
        #
        # vdd
        # gnd

        self.add_bitline_pins()
        self.add_wordline_pins()
        self.add_pin("vdd", "POWER")
        self.add_pin("gnd", "GROUND")

    def add_bitline_pins(self):
        # these four are only included for compatibility with other modules
        self.bitline_names = self.replica_bitcell_array.bitline_names
        self.all_bitline_names = self.replica_bitcell_array.all_bitline_names
        self.rbl_bitline_names = self.replica_bitcell_array.rbl_bitline_names
        self.all_rbl_bitline_names = self.replica_bitcell_array.all_rbl_bitline_names

        # this one is actually used (obviously)
        self.bitline_pin_list = self.replica_bitcell_array.bitline_pin_list
        self.add_pin_list(self.bitline_pin_list, "INOUT")

    def add_wordline_pins(self):
        # some of these are just included for compatibility with modules instantiating this module
        self.rbl_wordline_names = self.replica_bitcell_array.rbl_wordline_names
        self.all_rbl_wordline_names = self.replica_bitcell_array.all_rbl_wordline_names
        self.wordline_names = self.replica_bitcell_array.wordline_names
        self.all_wordline_names = self.replica_bitcell_array.all_wordline_names

        self.used_wordline_names = self.replica_bitcell_array.used_wordline_names
        self.unused_wordline_names = self.replica_bitcell_array.unused_wordline_names
        self.replica_array_wordline_names_with_grounded_wls = ["gnd" if x in self.unused_wordline_names else x for x in self.replica_bitcell_array.wordline_pin_list]

        self.wordline_pin_list = []
        self.wordline_pin_list.extend(["gnd"] * len(self.col_cap_top.get_wordline_names()))
        self.wordline_pin_list.extend(self.replica_array_wordline_names_with_grounded_wls)
        self.wordline_pin_list.extend(["gnd"] * len(self.col_cap_bottom.get_wordline_names()))

        self.add_pin_list(self.used_wordline_names, "INPUT")

    def create_instances(self):
        """ Create the module instances used in this design """
        self.supplies = ["vdd", "gnd"]

        # Main array
        self.replica_bitcell_array_inst=self.add_inst(name="replica_bitcell_array",
                                                      mod=self.replica_bitcell_array)
        self.connect_inst(self.bitline_pin_list + self.replica_array_wordline_names_with_grounded_wls + self.supplies)

        # Top/bottom dummy rows or col caps
        self.dummy_row_insts = []
        self.dummy_row_insts.append(self.add_inst(name="dummy_row_bot",
                                                  mod=self.col_cap_bottom))
        self.connect_inst(self.bitline_pin_list + ["gnd"] * len(self.col_cap_bottom.get_wordline_names()) + self.supplies)
        self.dummy_row_insts.append(self.add_inst(name="dummy_row_top",
                                                  mod=self.col_cap_top))
        self.connect_inst(self.bitline_pin_list + ["gnd"] * len(self.col_cap_top.get_wordline_names()) + self.supplies)

        # Left/right Dummy columns
        self.dummy_col_insts = []
        self.dummy_col_insts.append(self.add_inst(name="dummy_col_left",
                                                    mod=self.row_cap_left))
        self.connect_inst(["dummy_left_" + bl for bl in self.row_cap_left.all_bitline_names] + self.wordline_pin_list + self.supplies)
        self.dummy_col_insts.append(self.add_inst(name="dummy_col_right",
                                                    mod=self.row_cap_right))
        self.connect_inst(["dummy_right_" + bl for bl in self.row_cap_right.all_bitline_names] + self.wordline_pin_list + self.supplies)

        # bitcell array needed for some offset calculations
        self.bitcell_array_inst = self.replica_bitcell_array.bitcell_array_inst

    def create_layout(self):

        # This creates space for the unused wordline connections as well as the
        # row-based or column based power and ground lines.
        self.vertical_pitch = 1.1 * getattr(self, "{}_pitch".format(self.supply_stack[0]))
        self.horizontal_pitch = 1.1 * getattr(self, "{}_pitch".format(self.supply_stack[2]))
        # FIXME: custom sky130 replica module has a better version of this offset
        self.unused_offset = vector(0.25, 0.25)

        # This is a bitcell x bitcell offset to scale
        self.bitcell_offset = vector(self.cell.width, self.cell.height)
        self.col_end_offset = vector(self.cell.width, self.cell.height)
        self.row_end_offset = vector(self.cell.width, self.cell.height)

        # Everything is computed with the replica array
        self.replica_bitcell_array_inst.place(offset=self.unused_offset)

        self.add_end_caps()

        # shift everything up and right to account for cap cells
        self.translate_all(self.bitcell_offset.scale(-1, -1))

        self.width = self.dummy_col_insts[1].rx() + self.unused_offset.x
        self.height = self.dummy_row_insts[1].uy()

        self.add_layout_pins()

        self.route_supplies()

        self.route_unused_wordlines()

        lower_left = self.find_lowest_coords()
        upper_right = self.find_highest_coords()
        self.width = upper_right.x - lower_left.x
        self.height = upper_right.y - lower_left.y
        self.translate_all(lower_left)

        self.add_boundary()

        self.DRC_LVS()

    def get_main_array_top(self):
        return self.replica_bitcell_array_inst.by() + self.replica_bitcell_array.get_main_array_top()

    def get_main_array_bottom(self):
        return self.replica_bitcell_array_inst.by() + self.replica_bitcell_array.get_main_array_bottom()

    def get_main_array_left(self):
        return self.replica_bitcell_array_inst.lx() + self.replica_bitcell_array.get_main_array_left()

    def get_main_array_right(self):
        return self.replica_bitcell_array_inst.lx() + self.replica_bitcell_array.get_main_array_right()

    # FIXME: these names need to be changed to reflect what they're actually returning
    def get_replica_top(self):
        return self.dummy_row_insts[1].by()

    def get_replica_bottom(self):
        return self.dummy_row_insts[0].uy()

    def get_replica_left(self):
        return self.dummy_col_insts[0].lx()

    def get_replica_right(self):
        return self.dummy_col_insts[1].rx()


    def get_column_offsets(self):
        """
        Return an array of the x offsets of all the regular bits
        """
        # must add the offset of the instance
        offsets = [self.replica_bitcell_array_inst.lx() + x for x in self.replica_bitcell_array.get_column_offsets()]
        return offsets

    def add_end_caps(self):
        """ Add dummy cells or end caps around the array """

        # Far top dummy row (first row above array is NOT flipped if even number of rows)
        flip_dummy = (self.row_size + self.rbl[1]) % 2
        dummy_row_offset = self.bitcell_offset.scale(0, flip_dummy) + self.replica_bitcell_array_inst.ul()
        self.dummy_row_insts[1].place(offset=dummy_row_offset,
                                      mirror="MX" if flip_dummy else "R0")

        # Far bottom dummy row (first row below array IS flipped)
        flip_dummy = (self.rbl[0] + 1) % 2
        dummy_row_offset = self.bitcell_offset.scale(0, flip_dummy - 1) + self.unused_offset
        self.dummy_row_insts[0].place(offset=dummy_row_offset,
                                      mirror="MX" if flip_dummy else "R0")
        # Far left dummy col
        # Shifted down by the number of left RBLs even if we aren't adding replica column to this bitcell array
        dummy_col_offset = self.bitcell_offset.scale(-1, -1) + self.unused_offset
        self.dummy_col_insts[0].place(offset=dummy_col_offset)

        # Far right dummy col
        # Shifted down by the number of left RBLs even if we aren't adding replica column to this bitcell array
        dummy_col_offset = self.bitcell_offset.scale(0, -1) + self.replica_bitcell_array_inst.lr()
        self.dummy_col_insts[1].place(offset=dummy_col_offset)




    #Modificado por Odilon
    def add_layout_pins(self):
        """
        Adiciona os pinos na periferia e faz o recuo exato de uma bitcell 
        para conectar na primeira célula sem avançar para o centro do array.
        """
        cell_w = self.cell.width
        cell_h = self.cell.height

        for pin_name in self.used_wordline_names + self.bitline_pin_list:
            # Captura o pino (que está vindo na segunda bitcell)
            pin = self.replica_bitcell_array_inst.get_pin(pin_name)

            if "wl" in pin_name:
                # WORDLINES: O pino lógico fica na borda externa (x=0)
                pin_offset = vector(0, pin.ll().y)
                pin_width  = pin.width()  
                pin_height = pin.height()
                
                # CORREÇÃO CIRÚRGICA: 
                # Se o pino lido está na segunda bitcell (pin.lx()), o alvo real na primeira bitcell
                # termina exatamente em: pin.lx() - cell_w.
                # O retângulo vai de x=0 até o pino da primeira bitcell, morrendo ali.
                rect_width = pin.lx() - cell_w
                
                if not OPTS.netlist_only and rect_width > 0:
                    self.add_rect(layer=pin.layer,
                                  offset=vector(0, pin.by()),
                                  width=rect_width,
                                  height=pin_height)
            else:
                # BITLINES: O pino lógico fica na base inferior (y=0)
                pin_offset = vector(pin.ll().x, 0)
                pin_width  = pin.width()
                pin_height = pin.height()
                
                # BITLINES: Faz o mesmo recuo vertical correspondente à altura de uma bitcell
                rect_height = pin.by() - cell_h
                if not OPTS.netlist_only and rect_height > 0:
                    self.add_rect(layer=pin.layer,
                                  offset=vector(pin.lx(), 0),
                                  width=pin_width,
                                  height=rect_height)

            # Força o OpenRAM a gerar o pino/marcador lógico na nova posição externa
            self.add_layout_pin(text=pin_name,
                                layer=pin.layer,
                                offset=pin_offset,
                                width=pin_width,
                                height=pin_height)




    #Modificado por Odilon   
    def route_supplies(self):
        """
        Modificado por Odilon: Desativados rails padrão do OpenRAM.
        Geração cirúrgica dos pinos dummy_bl e dummy_br (verticais na base Y=0),
        e dos pinos de vdd e gnd (horizontais na borda esquerda X=0), casando 
        perfeitamente com o pitch das células funcionais.
        """
        # ======================================================================
        # 1. TRILHOS DE ALIMENTAÇÃO ORIGINAIS DO OPENRAM - COMPLETAMENTE REMOVIDOS
        # ======================================================================
        pass

        # Configurações geométricas básicas compartilhadas
        cell_w = self.cell.width
        cell_h = self.cell.height

        # Definição das camadas e dimensões padrão da TSMC65N (Ajuste se necessário)
        # Como o VDD/GND corre na horizontal, geralmente usam a mesma camada das WLs (ex: Metal1 ou Metal3)
        supply_layer = "m1" 
        supply_w = 0.10 # Largura mínima de trilha/pino horizontal no seu PDK
        supply_h = 0.10

        # ======================================================================
        # 2. GERAÇÃO CIRÚRGICA DOS PINOS DUMMY_BL E DUMMY_BR (BASE INFERIOR Y=0)
        # ======================================================================
        sample_bl = None
        sample_br = None
        for p_name in self.bitline_pin_list:
            try:
                pin = self.replica_bitcell_array_inst.get_pin(p_name)
                if p_name.startswith("bl") and sample_bl is None:
                    sample_bl = pin
                elif p_name.startswith("br") and sample_br is None:
                    sample_br = pin
            except:
                pass

        if sample_bl and sample_br:
            bl_layer = sample_bl.layer
            bl_w = sample_bl.width()
            bl_h = sample_bl.height()
            rect_height = sample_bl.by() - cell_h

            total_layout_cols = int(self.width / cell_w) + 1
            dummy_bl_idx = 0

            for col_idx in range(total_layout_cols):
                x_offset = col_idx * cell_w
                is_functional_col = False
                for p_name in self.bitline_pin_list:
                    try:
                        f_pin = self.replica_bitcell_array_inst.get_pin(p_name)
                        if abs(f_pin.lx() - x_offset) < (cell_w * 0.4):
                            is_functional_col = True
                            break
                    except:
                        pass
                
                if not is_functional_col:
                    rel_bl_x = sample_bl.lx() % cell_w
                    rel_br_x = sample_br.lx() % cell_w
                    
                    target_bl_x = x_offset + rel_bl_x
                    target_br_x = x_offset + rel_br_x

                    # ==========================================================
                    # CORREÇÃO CIRÚRGICA DE ESPELHAMENTO DUMMY DIREITA
                    # Recua 1 cell_w nos dummies do lado direito (dummy_bl_1, dummy_br_1, etc.)
                    # ==========================================================
                    if dummy_bl_idx > 0 or col_idx == total_layout_cols - 1:
                        target_bl_x -= cell_w
                        target_br_x -= cell_w

                    # --- BL DUMMY ---
                    bl_pin_name = "dummy_bl_{0}".format(dummy_bl_idx)
                    if not OPTS.netlist_only and rect_height > 0:
                        self.add_rect(layer=bl_layer, offset=vector(target_bl_x, 0), width=bl_w, height=rect_height)
                    self.add_layout_pin(text=bl_pin_name, layer=bl_layer, offset=vector(target_bl_x, 0), width=bl_w, height=bl_h)

                    # --- BR DUMMY ---
                    br_pin_name = "dummy_br_{0}".format(dummy_bl_idx)
                    if not OPTS.netlist_only and rect_height > 0:
                        self.add_rect(layer=bl_layer, offset=vector(target_br_x, 0), width=bl_w, height=rect_height)
                    self.add_layout_pin(text=br_pin_name, layer=bl_layer, offset=vector(target_br_x, 0), width=bl_w, height=bl_h)
                    
                    dummy_bl_idx += 1

        # ======================================================================
        # 3. NOVA GERAÇÃO CIRÚRGICA DOS PINOS DE VDD E GND (BORDA ESQUERDA X=0)
        # ======================================================================
        # Altere este valor (em micrômetros) para empurrar todos os pinos para cima!
        # Se estava shiftado para baixo, tente começar com valores como 0.1, 0.2 ou a metade de supply_h
        FATOR_CORRECAO_Y = 0.20  # <- MUDE AQUI (Ex: 0.12 ou 0.08) para alinhar perfeitamente
        # Varre a altura total do bloco linha por linha do grid físico
        total_layout_rows = int(self.height / cell_h) + 1
        
        # Normalmente, as bitcells comerciais alternam linhas de GND e VDD comuns ou compartilham rails.
        # Caso a sua célula possua trilhos internos fixos (Ex: GND na base y=0 e VDD no topo y=cell_h de cada célula):
        for row_idx in range(total_layout_rows):
            y_offset = row_idx * cell_h
            
            # Ajuste cirúrgico do comprimento do metal (rect_width):
            # O pino nasce na borda extrema X=0 e morre exatamente na borda da primeira célula (cell_w)
            # de forma idêntica à lógica que usamos no recuo de Wordline para não gerar curtos!
            rect_width = cell_w * 0.5  # Avança apenas metade de uma célula para fazer o tie seguro na periferia
            
            # Identificação das linhas de VDD e GND baseadas na topologia de alternância padrão do OpenRAM.
            # Geralmente as linhas pares são conectadas ao GND e as ímpares ao VDD (ou vice-versa).
            # Ajuste o índice binário abaixo se a ordem no seu PDK for invertida:
            if row_idx % 2 == 0:
                pin_type_name = "gnd_{0}".format(row_idx)
                # Offset Y relativo interno do rail de GND na célula (ex: bem no centro ou na base)
                # Usamos y_offset direto assumindo que o rail fica na borda da célula
                target_y = y_offset + FATOR_CORRECAO_Y
            else:
                pin_type_name = "vdd_{0}".format(row_idx)
                target_y = y_offset + FATOR_CORRECAO_Y

            # Desenha o retângulo de metal horizontal curto na borda esquerda
            if not OPTS.netlist_only and rect_width > 0:
                self.add_rect(layer=supply_layer,
                              offset=vector(0, target_y),
                              width=rect_width,
                              height=supply_h)

            # Declara o pino periférico formal para que o Innovus o enxergue no LEF
            self.add_layout_pin(text=pin_type_name,
                                layer=supply_layer,
                                offset=vector(0, target_y),
                                width=supply_w,
                                height=supply_h)




    def route_unused_wordlines(self):
        """
        Reativado de forma customizada: Varre as instâncias de dummy rows (topo/base)
        e gera pinos lógicos individuais curtos em X=0 conectando-os por retângulos,
        casando perfeitamente com a lógica das células funcionais.
        """
        cell_w = self.cell.width
        dummy_wl_idx = 0

        # 1. TRATAMENTO PARA AS LINHAS DUMMY (Top/Bottom) - Resolve o canto superior/inferior esquerdo
        for inst in self.dummy_row_insts:
            # Obtém os nomes de wordline internos da célula dummy cap
            for wl_name in self.col_cap_top.get_wordline_names():
                try:
                    # Captura o pino interno de WL da célula dummy
                    pin = inst.get_pin(wl_name)
                    
                    # Nome exclusivo para o pino lógico na netlist (ex: dummy_wl_0, dummy_wl_1)
                    dummy_pin_name = "dummy_wl_{0}".format(dummy_wl_idx)
                    dummy_wl_idx += 1
                    
                    # O pino para o Innovus ficará na borda externa extrema (x=0)
                    pin_offset = vector(0, pin.ll().y)
                    
                    # Aplica exatamente a mesma lógica de recuo da célula funcional:
                    # Se o pino interno já vem indexado à frente, recua 1 bitcell (cell_w)
                    rect_width = pin.lx() - cell_w
                    
                    # Fallback de segurança se ela estiver fisicamente mais recuada
                    if rect_width <= 0:
                        rect_width = pin.lx()

                    # Desenha o metal de extensão preciso apenas cobrindo o gap perimetral
                    if not OPTS.netlist_only and rect_width > 0:
                        self.add_rect(layer=pin.layer,
                                      offset=vector(0, pin.by()),
                                      width=rect_width,
                                      height=pin.height())

                    # Declara o pino lógico periférico para o LEF
                    self.add_layout_pin(text=dummy_pin_name,
                                        layer=pin.layer,
                                        offset=pin_offset,
                                        width=pin.width(),
                                        height=pin.height())
                except:
                    pass

        # 2. TRATAMENTO PARA WORDLINES DE RÉPLICA NÃO UTILIZADAS (Se houver)
        for wl_name in self.unused_wordline_names:
            try:
                pin = self.replica_bitcell_array_inst.get_pin(wl_name)
                dummy_pin_name = "dummy_wl_{0}".format(dummy_wl_idx)
                dummy_wl_idx += 1
                
                rect_width = pin.lx() - cell_w
                if rect_width <= 0:
                    rect_width = pin.lx()

                if not OPTS.netlist_only and rect_width > 0:
                    self.add_rect(layer=pin.layer,
                                  offset=vector(0, pin.by()),
                                  width=rect_width,
                                  height=pin.height())

                self.add_layout_pin(text=dummy_pin_name,
                                    layer=pin.layer,
                                    offset=vector(0, pin.ll().y),
                                    width=pin.width(),
                                    height=pin.height())
            except:
                pass

    def route_side_pin(self, name, side, offset_multiple=1):
        """
        Routes a vertical or horizontal pin on the side of the bbox.
        The multiple specifies how many track offsets to be away from the side assuming
        (0,0) (self.width, self.height)
        """
        if side in ["left", "right"]:
            return self.route_vertical_side_pin(name, side, offset_multiple)
        elif side in ["top", "bottom", "bot"]:
            return self.route_horizontal_side_pin(name, side, offset_multiple)
        else:
            debug.error("Invalid side {}".format(side), -1)

    def route_vertical_side_pin(self, name, side, offset_multiple=1):
        """
        Routes a vertical pin on the side of the bbox.
        """
        if side == "left":
            bot_loc = vector(-offset_multiple * self.vertical_pitch, 0)
            top_loc = vector(-offset_multiple * self.vertical_pitch, self.height)
        elif side == "right":
            bot_loc = vector(self.width + offset_multiple * self.vertical_pitch, 0)
            top_loc = vector(self.width + offset_multiple * self.vertical_pitch, self.height)

        layer = self.supply_stack[2]
        top_via = contact(layer_stack=self.supply_stack,
                          directions=("H", "H"))

        self.add_layout_pin_segment_center(text=name,
                                           layer=layer,
                                           start=bot_loc,
                                           end=top_loc,
                                           width=top_via.second_layer_width)

        return (bot_loc, top_loc)

    #Modificado por Odilon
    def route_horizontal_side_pin(self, name, side, offset_multiple=1):
        """
        Routes a horizontal pin on the side of the bbox.
        Modificado: Encurta o metal para não esticar por toda a largura (self.width).
        """
        layer = self.supply_stack[0]
        side_via = contact(layer_stack=self.supply_stack,
                           directions=("V", "V"))
        
        # Tamanho mínimo baseado na própria via de conexão (evita erro de DRC de tamanho mínimo)
        pin_length = side_via.first_layer_width if hasattr(side_via, 'first_layer_width') else side_via.width

        if side in ["bottom", "bot"]:
            # CORREÇÃO: Altera de self.width para pin_length (pino fica restrito à borda esquerda)
            left_loc = vector(0, -offset_multiple * self.horizontal_pitch)
            right_loc = vector(pin_length, -offset_multiple * self.horizontal_pitch)
        elif side == "top":
            # CORREÇÃO: Idem para o topo
            left_loc = vector(0, self.height + offset_multiple * self.horizontal_pitch)
            right_loc = vector(pin_length, self.height + offset_multiple * self.horizontal_pitch)

        self.add_layout_pin_segment_center(text=name,
                                           layer=layer,
                                           start=left_loc,
                                           end=right_loc,
                                           width=side_via.first_layer_height)

        return (left_loc, right_loc)


    def connect_side_pin(self, pin, side, offset):
        """
        Used to connect a pin to the a horizontal or vertical strap
        offset gives the location of the strap
        """
        if side in ["left", "right"]:
            self.connect_vertical_side_pin(pin, offset)
        elif side in ["top", "bottom", "bot"]:
            self.connect_horizontal_side_pin(pin, offset)
        else:
            debug.error("Invalid side {}".format(side), -1)

    def connect_horizontal_side_pin(self, pin, yoffset):
        """
        Used to connect a pin to the top/bottom horizontal straps
        """
        cell_loc = pin.center()
        pin_loc = vector(cell_loc.x, yoffset)

        # Place the pins a track outside of the array
        self.add_via_stack_center(offset=pin_loc,
                                  from_layer=pin.layer,
                                  to_layer=self.supply_stack[0],
                                  directions=("V", "V"))

        # Add a path to connect to the array
        self.add_path(pin.layer, [cell_loc, pin_loc])

    def connect_vertical_side_pin(self, pin, xoffset):
        """
        Used to connect a pin to the left/right vertical straps
        """
        cell_loc = pin.center()
        pin_loc = vector(xoffset, cell_loc.y)

        # Place the pins a track outside of the array
        self.add_via_stack_center(offset=pin_loc,
                                  from_layer=pin.layer,
                                  to_layer=self.supply_stack[2],
                                  directions=("H", "H"))

        # Add a path to connect to the array
        self.add_path(pin.layer, [cell_loc, pin_loc])

    def analytical_power(self, corner, load):
        """Power of Bitcell array and bitline in nW."""
        # Dynamic Power from Bitline
        bl_wire = self.gen_bl_wire()
        cell_load = 2 * bl_wire.return_input_cap()
        bl_swing = OPTS.rbl_delay_percentage
        freq = spice["default_event_frequency"]
        bitline_dynamic = self.calc_dynamic_power(corner, cell_load, freq, swing=bl_swing)

        # Calculate the bitcell power which currently only includes leakage
        cell_power = self.cell.analytical_power(corner, load)

        # Leakage power grows with entire array and bitlines.
        total_power = self.return_power(cell_power.dynamic + bitline_dynamic * self.column_size,
                                        cell_power.leakage * self.column_size * self.row_size)
        return total_power


    def gen_bl_wire(self):
        if OPTS.netlist_only:
            height = 0
        else:
            height = self.height
        bl_pos = 0
        bl_wire = self.generate_rc_net(int(self.row_size - bl_pos), height, drc("minwidth_m1"))
        bl_wire.wire_c =spice["min_tx_drain_c"] + bl_wire.wire_c # 1 access tx d/s per cell
        return bl_wire

    def graph_exclude_bits(self, targ_row=None, targ_col=None):
        """
        Excludes bits in column from being added to graph except target
        """
        self.replica_bitcell_array.graph_exclude_bits(targ_row, targ_col)

    def graph_exclude_replica_col_bits(self):
        """
        Exclude all replica/dummy cells in the replica columns except the replica bit.
        """
        self.replica_bitcell_array.graph_exclude_replica_col_bits()

    def get_cell_name(self, inst_name, row, col):
        """
        Gets the spice name of the target bitcell.
        """
        return self.replica_bitcell_array.get_cell_name(inst_name + "{}x".format(OPTS.hier_seperator) + self.replica_bitcell_array_inst.name, row, col)

    def clear_exclude_bits(self):
        """
        Clears the bit exclusions
        """
        self.replica_bitcell_array.clear_exclude_bits()
