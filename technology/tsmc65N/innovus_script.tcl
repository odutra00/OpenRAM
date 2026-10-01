################################################################################
#           SCRIPT DE FLOORPLAN, PLACEMENT E ROUTE - OPENRAM SRAM
# Autor: Assistente IA / Odilon
# Ferramenta: Cadence Innovus
################################################################################

# ==============================================================================
# 0. INICIALIZAÇÃO DO DESIGN (SET DE VARIAVEIS E IMPORTAÇÃO DAS LEFs E NETLIST)
# ==============================================================================
puts "--> (0/11) Carregando Netlist, LEFs e Design para a Memória..."
# Variaveis

#FloorPlan
#Core Utilization in percentage
set ASPECT_RATIO 1.35 
set CORE_UTILIZATION 0.6
set MARGIN_LEFT 20
set MARGIN_BOTTOM 20
set MARGIN_RIGHT 20
set MARGIN_TOP 15

# Vertical space between macros em um
set VERTICAL_OFFSET_BETWEEN_MACROS 2
# Horizontal space on the right side of macros to match horizontal alignment of pins
# in macro cell - negative values bring the macro to the left
set HORIZONTAL_OFFSET_RIGHT_PRECHARGE -2.1605
set HORIZONTAL_OFFSET_RIGHT_SENSE_AMP -2.1605
set HORIZONTAL_OFFSET_RIGHT_WRITE_DRIVER -2.1605

# --- Posicionamento dos Pinos 
# --- Parâmetros de Offset (em micras) em relação ao centro de cada lado  ---
# Valores positivos deslocam para Direita (Horizontal) ou Cima (Vertical)
# Valores negativos deslocam para Esquerda (Horizontal) ou Baixo (Vertical)
set OFFSET_ESQUERDO  -10.0
set OFFSET_DIREITO   -10.0
set OFFSET_BAIXO     -5.0
set OFFSET_CIMA      -1.0
# Margem no entorno das macros em um para afastar standard cells
set HALO_TO_BLOCKS 	1


# Direcionadores do PDK no Servidor
set PDK_DIR     "/apps/PDKs/Cadence/TSMC65/Digital"
set LIB_FILE    "$PDK_DIR/libs/tcbn65lptc.lib"
set CAP_TABLE   "$PDK_DIR/captables/cln65lp_1p09m+alrdl_top2_typical.captable"
set LEF_FILES	{
    /apps/PDKs/Cadence/TSMC65/Digital/lefs/tcbn65lp_9lmT2.lef
    /home/odutra/Work/TSMC65_1p9m_6x1z1u/lefs_SRAM/sram_32_1024_1rw_tsmc65N/sram_32_1024_1rw_tsmc65N_tsmc65N_capped_replica_bitcell_array.lef
    /home/odutra/Work/TSMC65_1p9m_6x1z1u/lefs_SRAM/sram_32_1024_1rw_tsmc65N/sram_32_1024_1rw_tsmc65N_tsmc65N_precharge_array.lef
    /home/odutra/Work/TSMC65_1p9m_6x1z1u/lefs_SRAM/sram_32_1024_1rw_tsmc65N/sram_32_1024_1rw_tsmc65N_tsmc65N_sense_amp_array.lef
    /home/odutra/Work/TSMC65_1p9m_6x1z1u/lefs_SRAM/sram_32_1024_1rw_tsmc65N/sram_32_1024_1rw_tsmc65N_tsmc65N_write_driver_array.lef
}
set VERILOG_PROJETO "lefs_SRAM/sram_32_1024_1rw_tsmc65N/sram_32_1024_1rw_tsmc65N.v"
set CELULA_TOPO "sram_32_1024_1rw_tsmc65N"
set ARQUIVO_SDC "lefs_SRAM/SRAM.sdc"
set POWER_NET "vdd"
set GROUND_NET "gnd"
################################################################
# A partir daqui não deveria ser necessário mudar mais nada, a menos que queira modificar o script
################################################################





# Define as variáveis de inicialização
# AJUSTE OS CAMINHOS E NOMES DOS ARQUIVOS CONFORME O SEU PROJETO:
# Configura o Innovus para carregar o design
setDesignMode -process 65
setImportMode -keepEmptyModule true
# setImportMode -config true 

# Arquivos do design
set init_lef_file $LEF_FILES
set init_verilog $VERILOG_PROJETO
set init_top_cell $CELULA_TOPO
set init_pwr_net $POWER_NET
set init_gnd_net $GROUND_NET

# Configuração de Timing e CapTable
set init_lib_file    $LIB_FILE
set init_sdc_file    $ARQUIVO_SDC
set init_cap_table_file $CAP_TABLE

# Chama o init_design SEM argumentos:
init_design
# gui_show


# Função para encontrar o nome da INSTÂNCIA a partir de um trecho do nome do MÓDULO/CÉLULA
proc findInstByCellPattern { pattern } {
    # Busca pares de {nome_da_instancia nome_da_celula} diretamente do banco de dados
    set instList [dbGet top.insts.name]
    set cellList [dbGet top.insts.cell.name]
    
    for {set i 0} {$i < [llength $cellList]} {incr i} {
        set cellName [lindex $cellList $i]
        set instName [lindex $instList $i]
        
        # Verifica se o padrão (ex: *capped_replica_bitcell_array*) está no nome da célula ou da instância
        if {[string match -nocase "*$pattern*" $cellName] || [string match -nocase "*$pattern*" $instName]} {
            puts "   (INFO) Macro encontrada para '$pattern': Instância = $instName (Célula = $cellName)"
            return $instName
        }
    }
    
    return -code error "   (ERRO CRÍTICO) Nenhuma macro com o padrão '$pattern' foi localizada!"
}







# ==============================================================================
# CONFIGURAÇÃO DE MMMC (TIMING + CAPTABLE)
# ==============================================================================
# TODO: Esta quebrando na linha set_analysis_view. Acusa o erro 
# **ERROR: (TCLCMD-1239):	The software has been initialized without timing library information into a physical-only mode of operation. Access to timing analysis related commands and functionality is not available in this mode.  To operate the software with full functionality you must exit or issue the freeDesign command - then reinitialize the system with a design configuration that includes a valid timing library configuration.

# puts "--> Configurando MMMC e associando CapTable/Lib..."

# Set do processo TSMC 65nm
# setDesignMode -process 65

# 1. Cria o RC Corner associando o arquivo .captable de 65nm
# create_rc_corner -name rc_typical -cap_table $CAP_TABLE

# 2. Cria o Library Set com os arquivos .lib
# create_library_set -name max_timing -timing [list $LIB_FILE]

# 3. Associa RC Corner + Lib Set no Delay Corner
# create_delay_corner -name delay_max -library_set max_timing -rc_corner rc_typical

# 4. Associa o arquivo SDC
# create_constraint_mode -name sdc_mode -sdc_files [list $ARQUIVO_SDC]

# 5. Define a Analysis View ativa no Innovus
# create_analysis_view -name view_typical -delay_corner delay_max -constraint_mode sdc_mode
# set_analysis_view -setup [list view_typical] -hold [list view_typical]



















# ==============================================================================
# 1. CONEXÃO DAS NETS GLOBAIS DE ALIMENTAÇÃO (POWER / GROUND)
# ==============================================================================
puts "--> (1/11) Conectando Nets Globais de Alimentação..."

globalNetConnect vdd -type pgpin -pin VDD -inst * -override
globalNetConnect vdd -type pgpin -pin vdd -inst * -override
globalNetConnect gnd -type pgpin -pin VSS -inst * -override
globalNetConnect gnd -type pgpin -pin gnd -inst * -override
globalNetConnect vdd -type tiehi -inst * -override
globalNetConnect gnd -type tielo -inst * -override















# ==============================================================================
# 2. CRIAÇÃO DO FLOORPLAN (H/W = 2.0)
# ==============================================================================
puts "--> (2/11) Criando o Floorplan (Aspect Ratio H/W em função das macros)..."

# Libera instâncias antigas se houver
# unplaceAll -force

# -r <aspect_ratio> <utilization> <margin_left> <margin_bottom> <margin_right> <margin_top>
# Ratio H/W = 2.0 (Altura = 2x Largura), Utilização = 60%, Margens de 20um para o Ring
floorPlan -r $ASPECT_RATIO $CORE_UTILIZATION $MARGIN_LEFT $MARGIN_BOTTOM $MARGIN_RIGHT $MARGIN_TOP

# TODO Tentar automatizar o floorplan pelo aspect ratio considerando H e W das macros
# é dificil pq a razao de aspecto da celula capped_replica_bitcell_array muda de acordo com a memoria.
# --- a) Bitcell Array (Top Right Corner colado no Top Right do Floorplan)
set bitcellInst [findInstByCellPattern "capped_replica_bitcell_array"]
# Pega a largura (box_w) e altura (box_h) da célula diretamente do DB do Innovus
set bitcellW [dbGet [dbGetInstByName $bitcellInst].box_sizex]
set bitcellH [dbGet [dbGetInstByName $bitcellInst].box_sizey]

# --- b) Precharge Array (5um abaixo do Bottom Right da bitcell)
set prechargeInst [findInstByCellPattern "precharge_array"]
set prechargeW [dbGet [dbGetInstByName $prechargeInst].box_sizex]
set prechargeH [dbGet [dbGetInstByName $prechargeInst].box_sizey]

# --- c) Sense Amp Array (5um abaixo do Bottom Right do precharge)
set senseInst [findInstByCellPattern "sense_amp_array"]
set senseW [dbGet [dbGetInstByName $senseInst].box_sizex]
set senseH [dbGet [dbGetInstByName $senseInst].box_sizey]

# --- d) Write Driver Array (5um abaixo do Bottom Right do sense_amp)
set writeInst [findInstByCellPattern "write_driver_array"]
set writeW [dbGet [dbGetInstByName $writeInst].box_sizex]
set writeH [dbGet [dbGetInstByName $writeInst].box_sizey]


set altura_macros [expr {$bitcellH + $prechargeH + $senseH + $writeH}]
set largura_macros [expr {$bitcellW}]

set soma_vertical_space_between_macros [expr {$VERTICAL_OFFSET_BETWEEN_MACROS * 3}]

set altura_macros [expr {$altura_macros + $soma_vertical_space_between_macros}]
set largura_macros [expr {$largura_macros + $HALO_TO_BLOCKS * 2}]
set largura_digital 15
set aspect_ratio [expr {$altura_macros / ($largura_digital + $largura_macros)}]

# -r <aspect_ratio> <utilization> <margin_left> <margin_bottom> <margin_right> <margin_top>
# floorPlan -r $aspect_ratio $CORE_UTILIZATION $MARGIN_LEFT $MARGIN_BOTTOM $MARGIN_RIGHT $MARGIN_TOP

puts stdout  "H= $altura_macros , W= $largura_macros "
puts stdout "FloorPlan --> AspectRatio $aspect_ratio , CoreUtilization = $CORE_UTILIZATION"















# ==============================================================================
# 3. CRIAÇÃO DO POWER RING (M1/M2, Width 1.8um, Spacing 1.8um)
# ==============================================================================
puts "--> (3/11) Criando o Power Ring (M1/M2)..."

# Define o estilo dos trilhos
addRing -type core_rings \
        -nets {vdd gnd} \
        -layer {top M2 bottom M2 left M1 right M1} \
        -width 1.8 \
        -spacing 1.8 \
        -offset 5.0 \
        -center 1

# O posicionamento das power strips acontecerão após o posicionamento
# das macros no item a seguir 4
















# ==============================================================================
# 4. POSICIONAMENTO RELATIVO DAS MACROS (BUSCA DINÂMICA E ALINHAMENTO)
# ==============================================================================
puts "--> (4/11) Posicionando Macros dinamicamente por Alinhamento de Cantos..."

# Extrai a lista de coordenadas do coreBox removendo aninhamentos Tcl
set coreBox [lindex [dbGet top.fPlan.coreBox] 0]
set coreLLX [lindex $coreBox 0]
set coreLLY [lindex $coreBox 1]
set coreURX [lindex $coreBox 2]
set coreURY [lindex $coreBox 3]



# --- a) Bitcell Array (Top Right Corner colado no Top Right do Floorplan)
set bitcellInst [findInstByCellPattern "capped_replica_bitcell_array"]
# Pega a largura (box_w) e altura (box_h) da célula diretamente do DB do Innovus
set bitcellW [dbGet [dbGetInstByName $bitcellInst].box_sizex]
set bitcellH [dbGet [dbGetInstByName $bitcellInst].box_sizey]
set bitcellX [expr {$coreURX - $bitcellW}]
set bitcellY [expr {$coreURY - $bitcellH}]
placeInstance $bitcellInst $bitcellX $bitcellY R0
dbSet [dbGetInstByName $bitcellInst].pStatus fixed

# --- b) Precharge Array (5um abaixo do Bottom Right da bitcell)
set prechargeInst [findInstByCellPattern "precharge_array"]
set prechargeW [dbGet [dbGetInstByName $prechargeInst].box_sizex]
set prechargeH [dbGet [dbGetInstByName $prechargeInst].box_sizey]
set prechargeX [expr {$coreURX - $prechargeW + $HORIZONTAL_OFFSET_RIGHT_PRECHARGE}] 
set prechargeY [expr {$bitcellY - $VERTICAL_OFFSET_BETWEEN_MACROS - $prechargeH}]
placeInstance $prechargeInst $prechargeX $prechargeY R0
dbSet [dbGetInstByName $prechargeInst].pStatus fixed

# --- c) Sense Amp Array (5um abaixo do Bottom Right do precharge)
set senseInst [findInstByCellPattern "sense_amp_array"]
set senseW [dbGet [dbGetInstByName $senseInst].box_sizex]
set senseH [dbGet [dbGetInstByName $senseInst].box_sizey]
set senseX [expr {$coreURX - $senseW + $HORIZONTAL_OFFSET_RIGHT_SENSE_AMP}]
set senseY [expr {$prechargeY - $VERTICAL_OFFSET_BETWEEN_MACROS - $senseH}]
placeInstance $senseInst $senseX $senseY R0
dbSet [dbGetInstByName $senseInst].pStatus fixed

# --- d) Write Driver Array (5um abaixo do Bottom Right do sense_amp)
set writeInst [findInstByCellPattern "write_driver_array"]
set writeW [dbGet [dbGetInstByName $writeInst].box_sizex]
set writeH [dbGet [dbGetInstByName $writeInst].box_sizey]
set writeX [expr {$coreURX - $writeW + $HORIZONTAL_OFFSET_RIGHT_WRITE_DRIVER}] 
set writeY [expr {$senseY - $VERTICAL_OFFSET_BETWEEN_MACROS - $writeH}]
placeInstance $writeInst $writeX $writeY R0
dbSet [dbGetInstByName $writeInst].pStatus fixed

# Adiciona Halo de 3um em volta das macros para afastar as standard cells
addHaloToBlock $HALO_TO_BLOCKS $HALO_TO_BLOCKS $HALO_TO_BLOCKS $HALO_TO_BLOCKS -allMacro






















# ==============================================================================
# 5. So agora podemos gerar as power strips (apos posicionamento da macros)
# ==============================================================================
# Conecta os pinos das macros/cells ao ring
puts "--> (5/11)  Gerando as power strips (apos posicionamento da macros)..."
sroute -connect { blockPin padPin padRing corePin floatingStripe } \
       -layerChangeRange { M1 M2 } \
       -blockPinTarget { nearestTarget } \
       -corePinTarget { firstAfterRowEnd } \
       -allowJogging 1 \
       -crossoverViaLayerRange { M1 M2 } \
       -nets { vdd gnd }



















# ==============================================================================
# 6. ATRIBUIÇÃO DE PINOS DE I/O DO TOPO
# ==============================================================================
puts "--> (6/11)  Distribuindo pinos de I/O nas bordas do chip..."

#Automatico ao centro de cada lado
# Entradas de Dados e Endereço na Esquerda (M2 - Vertical)
# editPin -pin [dbGet top.terms.name din0*]   -side LEFT -layer 2 -spreadType CENTER
# editPin -pin [dbGet top.terms.name addr0*]  -side LEFT -layer 2 -spreadType CENTER
# Saídas na Direita (M2 - Vertical)
# editPin -pin [dbGet top.terms.name dout0*]  -side RIGHT -layer 2 -spreadType CENTER
# Sinais de Controle e Alimentação na Borda Inferior (M3 - Horizontal)
# editPin -pin {clk0 csb0 web0 gnd}       -side BOTTOM -layer 3 -spreadType CENTER
# editPin -pin {vdd}                      -side TOP -layer 3 -spreadType CENTER



# ATRIBUIÇÃO DE PINOS DE I/O DO TOPO (PARAMETRIZADO COM OFFSET)
# --- Extrai a caixa delimitadora do Die (dbGet top.fPlan.box) ---
set dieBox [lindex [dbGet top.fPlan.box] 0]
set dieLLX [lindex $dieBox 0]
set dieLLY [lindex $dieBox 1]
set dieURX [lindex $dieBox 2]
set dieURY [lindex $dieBox 3]

set dieCenterX [expr {($dieLLX + $dieURX) / 2.0}]
set dieCenterY [expr {($dieLLY + $dieURY) / 2.0}]

# --- PONTOS INICIAIS CALCULADOS COM OFFSET ---
set Y_Esquerda [expr {$dieCenterY + $OFFSET_ESQUERDO}]
set Y_Direita  [expr {$dieCenterY + $OFFSET_DIREITO}]
set X_Baixo    [expr {$dieCenterX + $OFFSET_BAIXO}]
set X_Cima     [expr {$dieCenterX + $OFFSET_CIMA}]


# --- APLICAÇÃO DOS PINOS ---

# Entradas de Dados e Endereço na Esquerda (M2 - Vertical)
set leftPins [concat [dbGet top.terms.name din0*] [dbGet top.terms.name addr0*]]
editPin -pin $leftPins -side LEFT -layer 2 -spreadType START -start [list $dieLLX $Y_Esquerda] -spacing 2.0

# Saídas na Direita (M2 - Vertical)
editPin -pin [dbGet top.terms.name dout0*] -side RIGHT -layer 2 -spreadType START -start [list $dieURX $Y_Direita] -spacing 2.0

# Sinais de Controle e Alimentação na Borda Inferior (M3 - Horizontal)
editPin -pin {clk0 csb0 web0 gnd} -side BOTTOM -layer 3 -spreadType START -start [list $X_Baixo $dieLLY] -spacing 2.0

# VDD na Borda Superior (M3 - Horizontal)
editPin -pin {vdd} -side TOP -layer 3 -spreadType START -start [list $X_Cima $dieURY] -spacing 2.0


# Confirmação no console
puts "Status dos pinos: [dbGet top.terms.pStatus]"

















# ==============================================================================
# 7. ROTEAMENTO DE ALIMENTAÇÃO (SROUTE - Sintaxe Limpa)
# ==============================================================================
puts "--> (7/11)  Conectando os pinos de alimentação (VDD/GND) às Power Stripes..."

# 1. Garante que as nets globais e tie-offs estejam associadas aos pinos do top
globalNetConnect vdd -type pgpin -pin vdd -inst * -override
globalNetConnect gnd -type pgpin -pin gnd -inst * -override
globalNetConnect vdd -type tiehi -inst *
globalNetConnect gnd -type tielo -inst *

# 2. Executa o sroute para ligar pinos das macros, pinos de I/O do top e stripes
sroute -connect { blockPin padPin corePin floatingStripe } \
       -layerChangeRange { 1 4 } \
       -blockPinTarget { nearestTarget } \
       -padPinPortConnect { allPort oneGeom } \
       -allowJog 1 \
       -allowLayerChange 1 \
       -targetViaLayerRange { 1 4 }














# ==============================================================================
# 8. PLACEMENT DAS STANDARD CELLS
# ==============================================================================
puts "--> (8/11) Executando Placement das Standard Cells..."

# Seta opções de posicionamento
# Configura placement flattening hierarquias digitais
# setPlaceMode -fp false

# Configura o placer para agrupar células pertencentes ao mesmo bloco hierárquico
setPlaceMode -place_global_cong_effort medium
setPlaceMode -place_global_ignore_spare false
# Faz o placement
place_design

# Otimização básica de Timing/Congestionamento após placement
optDesign -preCTS




















# 9. ADIÇÃO DE FILLER CELLS (PREENCHIMENTO DE LACUNAS DA SUBSTRATO/WELL)
# ==============================================================================
puts "--> (9/11) Adicionando Filler Cells..."

# AJUSTE AS CÉLULAS FILLER CONFORME SUA BIBLIOTECA TSMC 65nm (ex: FILL1D0, FILL2D0, FILL4D0...)
set fillerCells {FILL1 FILL1_LL FILL2 FILL4 FILL8 FILL16 FILL32 FILL64}

addFiller -cell $fillerCells -prefix FILLER






















# ==============================================================================
# 10. ROTEAMENTO GLOBAL E DETALHADO (NANOROUTE)
# ==============================================================================
puts "--> (10/11) Executando Roteamento (NanoRoute)..."

# Define as camadas limites pelo modo moderno (setDesignMode)
setDesignMode -topRoutingLayer 6
setDesignMode -bottomRoutingLayer 1

# Permite colocação de vias diretamente sobre/dentro dos pinos das macros em M1/M2
setNanoRouteMode -quiet -routeWithViaInPin true

# Desativa esforço TDR para evitar voltas motivadas por timing
setNanoRouteMode -quiet -routeTdrEffort 0

# Prepara a extração RC com a CapTable e desativa otimização por timing
setNanoRouteMode -routeWithTimingDriven false
setNanoRouteMode -routeWithSiDriven false

# Executa o roteamento detalhado
routeDesign









# ==============================================================================
# 11. Checagem de violações no roteamento
# ==============================================================================
puts "--> (11/11) Checagem de violações no roteamento..."
verifyConnectivity -type all
verify_drc

puts "========================================================================"
puts "  FLUXO CONCLUÍDO COM SUCESSO!"
puts "========================================================================"

# Mantém o terminal em loop aguardando entradas e impede o fechamento da GUI
vwait forever
