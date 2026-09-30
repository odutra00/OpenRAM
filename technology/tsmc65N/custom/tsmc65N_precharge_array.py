# See LICENSE for licensing information.
#
# Copyright (c) 2016-2024 Regents of the University of California and The Board
# of Regents for the Oklahoma Agricultural and Mechanical College
# (acting for and on behalf of Oklahoma State University)
# All rights reserved.
#
from openram import debug
from openram.base import design
from openram.base import vector
from openram.sram_factory import factory
from openram import OPTS

#Modificado Por Odilon para geraçao do lef dos modulos flattened
from openram.base import lef


class tsmc65N_precharge_array(design, lef):
    """
    Dynamically generated precharge array of all bitlines.  Cols is number
    of bit line columns, height is the height of the bit-cell array.
    """

    def __init__(self, name, columns, offsets=None, size=1, bitcell_bl="bl", bitcell_br="br", column_offset=0):
        super().__init__(name)
        #Modificado por Odilon para geracao do lef nos arrays flattened
        design.__init__(self, name)
        lef.__init__(self, ["m1", "m2", "m3", "m4"])
        #Modificado por Odilon
        debug.info(1, "Creating {0}".format(self.name))
        self.add_comment("cols: {0} size: {1} bl: {2} br: {3}".format(columns, size, bitcell_bl, bitcell_br))

        self.columns = columns
        self.offsets = offsets
        self.size = size
        self.bitcell_bl = bitcell_bl
        self.bitcell_br = bitcell_br
        self.column_offset = column_offset

        if OPTS.tech_name == "sky130":
            self.en_bar_layer = "m3"
        else:
            self.en_bar_layer = "m1"

        self.create_netlist()
        if not OPTS.netlist_only:
            self.create_layout()

    def get_bl_name(self):
        bl_name = self.pc_cell.get_bl_names()
        return bl_name

    def get_br_name(self):
        br_name = self.pc_cell.get_br_names()
        return br_name

    def add_pins(self):
        """Adds pins for spice file"""
        for i in range(self.columns):
            # These are outputs from the precharge only
            self.add_pin("bl_{0}".format(i), "OUTPUT")
            self.add_pin("br_{0}".format(i), "OUTPUT")
        self.add_pin("en_bar", "INPUT")
        self.add_pin("vdd", "POWER")

    def create_netlist(self):
        self.add_modules()
        self.add_pins()
        self.create_insts()

    def create_layout(self):
        self.place_insts()

        self.width = self.offsets[-1] + self.pc_cell.width
        self.height = self.pc_cell.height

        self.add_layout_pins()
        self.route_supplies()
        self.add_boundary()
        self.DRC_LVS()

    def add_modules(self):
        self.pc_cell = factory.create(module_type=OPTS.precharge,
                                      size=self.size,
                                      bitcell_bl=self.bitcell_bl,
                                      bitcell_br=self.bitcell_br)

        self.cell = factory.create(module_type=OPTS.bitcell)















   






    def create_insts(self):
        """Creates a precharge array by horizontally tiling the precharge cell"""
        self.local_insts = []
        for i in range(self.columns):
            name = "pre_column_{0}".format(i)
            offset = vector(self.pc_cell.width * i, 0)
            inst = self.add_inst(name=name,
                                 mod=self.pc_cell,
                                 offset=offset)
            self.local_insts.append(inst)
            self.connect_inst(["bl_{0}".format(i), "br_{0}".format(i), "en_bar", "vdd"])

    def place_insts(self):
        """ Places precharge array by horizontally tiling the precharge cell"""

        # Default to single spaced columns
        if not self.offsets:
            self.offsets = [n * self.pc_cell.width for n in range(self.columns)]

        for i, xoffset in enumerate(self.offsets):
            if self.cell.mirror.y and (i + self.column_offset) % 2:
                mirror = "MY"
                tempx = xoffset + self.pc_cell.width
            else:
                mirror = ""
                tempx = xoffset

            offset = vector(tempx, 0)
            self.local_insts[i].place(offset=offset, mirror=mirror)
















    #def add_layout_pins(self):

    #    en_pin = self.pc_cell.get_pin("en_bar")
    #    self.route_horizontal_pins("en_bar", layer=self.en_bar_layer)
    #    for inst in self.local_insts:
    #        self.add_via_stack_center(from_layer=en_pin.layer,
    #                                  to_layer=self.en_bar_layer,
    #                                  offset=inst.get_pin("en_bar").center())
    #
    #    for i in range(len(self.local_insts)):
    #        inst = self.local_insts[i]
    #        self.copy_layout_pin(inst, "bl", "bl_{0}".format(i))
    #        self.copy_layout_pin(inst, "br", "br_{0}".format(i))


    #Modificado por Odilon
    def add_layout_pins(self):
        # ============================================================
        # EN_BAR - um unico pino horizontal para todo o array
        # ============================================================
        en_pin = self.pc_cell.get_pin("en_bar")

        en_layer = self.en_bar_layer
        en_h = 0.14 #en_pin.height()

        EN_BAR_FIXED_Y = 1.375

        if not OPTS.netlist_only:
            self.add_rect(
                layer=en_layer,
                offset=vector(0, EN_BAR_FIXED_Y),
                width=self.width,
                height=en_h
            )

        self.add_layout_pin(
            text="en_bar",
            layer=en_layer,
            offset=vector(0, EN_BAR_FIXED_Y),
            width=en_h,
            height=en_h
        )

        for i in range(len(self.local_insts)):
            inst = self.local_insts[i]

            bl_pin = inst.get_pin(inst.mod.get_bl_names())
            br_pin = inst.get_pin(inst.mod.get_br_names())

            # ==================================================================
            # DEFINE A ALTURA MÍNIMA DOS PINOS DE EMBOCADURA (EVITA REFAZER TRILHAS)
            # ==================================================================
            # Pegamos o próprio width da trilha vertical em M2 para usar como altura mínima (formando um quadrado)
            # ou usamos uma altura muito pequena (ex: a largura da própria trilha original).
            pin_h = bl_pin.width() 

            # Colocamos o offset Y do pino na borda SUPERIOR da trilha para encostar no bloco de cima (abutment)
            # Se preferir na borda INFERIOR, altere bl_pin.uy() - pin_h para bl_pin.by()
            bl_offset = vector(bl_pin.lx(), bl_pin.uy() - pin_h)
            br_offset = vector(br_pin.lx(), br_pin.uy() - pin_h)


            # --- GERAÇÃO DOS PINOS CURTOS/QUADRADOS NA PERIFERIA ---
            self.add_layout_pin(text=self.get_bl_name() + "_{0}".format(i),
                                layer=bl_pin.layer,
                                offset=bl_offset,
                                width=bl_pin.width(),
                                height=pin_h)
                                
            self.add_layout_pin(text=self.get_br_name() + "_{0}".format(i),
                                layer=br_pin.layer,
                                offset=br_offset,
                                width=br_pin.width(),
                                height=pin_h)




#    def route_rails(self):
#        """
#        Modificado por Odilon: Desenha a trilha de enable (en) de forma que ela
#        não se prolongue à esquerda, gerando um pino curto e formal em X=0
#        para o Innovus rotear, mantendo o abutment interno por M1.
#        """
#        en_layer = self.en_bar_layer
#        en_h = 0.14
#
#        EN_BAR_FIXED_Y = 0.505

#        if not OPTS.netlist_only:
#            self.add_rect(
#                layer=en_layer,
#                offset=vector(0, EN_BAR_FIXED_Y),
#                width=self.width,
#                height=en_h
#            )

 #       self.add_layout_pin(
 #           text="en_bar",
 #           layer=en_layer,
 #           offset=vector(0, EN_BAR_FIXED_Y),
 #           width=en_h,
 #           height=en_h
 #       )





    #Modificado por Odilon - route_horizontal_pins acaba adicionando via, que sao desenhadas erroneamente. já deixei exposto no layout entao nao precisa de vias
    #def route_supplies(self):
    #    self.route_horizontal_pins("vdd")
    def route_supplies(self):
        """
        Modificado por Odilon: Passa as trilhas horizontais em coordenadas 
        lineares fixas calibradas manualmente para casar com o layout full-custom,
        anulando o efeito do espelhamento/rotação de instâncias.
        """
        supply_layer = "m3" # Altere para a camada correta se for m3
        supply_h = 0.14     # Altura da sua trilha de metal

        # ======================================================================
        # CALIBRAÇÃO MANUAL DE COORDENADAS Y (Em micrômetros)
        # ======================================================================
        # Olhe no visualizador e mude esses números para bater exatamente
        # com a posição dos trilhos da sua célula customizada na primeira linha.
        VDD_FIXED_Y = 0.505  # <- Ajuste este valor
        #GND_FIXED_Y = 4.115  # <- Ajuste este valor

        if not OPTS.netlist_only:
            # Traça o retângulo horizontal de VDD de ponta a ponta
            self.add_rect(layer=supply_layer,
                          offset=vector(0, VDD_FIXED_Y),
                          width=self.width,
                          height=supply_h)
                          
            # Traça o retângulo horizontal de GND de ponta a ponta
            #self.add_rect(layer=supply_layer,
            #              offset=vector(0, GND_FIXED_Y),
            #              width=self.width,
            #              height=supply_h)

        # Força os pinos lógicos curtos na borda esquerda (X=0)
        self.add_layout_pin(text="vdd",
                            layer=supply_layer,
                            offset=vector(0, VDD_FIXED_Y),
                            width=supply_h,
                            height=supply_h)

        #self.add_layout_pin(text="gnd",
        #                    layer=supply_layer,
        #                    offset=vector(0, GND_FIXED_Y),
        #                    width=supply_h,
        #                    height=supply_h)
