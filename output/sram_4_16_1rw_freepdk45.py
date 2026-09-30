import os

# 1. Define a tecnologia TSMC 65nm
tech_name = "freepdk45"

# Define o diretório de saída para os arquivos gerados
output_path = "output"

# (Opcional) Define o nome base do projeto/arquivos
output_name = "sram_4_16_1rw_freepdk45"

# 2. Configurações da Memória (Ajuste a palavra e número de palavras)
num_words = 16
word_size = 4
num_banks = 1

# 3. Nomes das Caixas-Pretas Full-Custom (Ficarão em technology/tsmc65N/gds_lib e sp_lib)
bitcell = "cell_1rw"
replica_bitcell = "replica_cell_1rw"
dummy_bitcell = "dummy_cell_1rw"
dff = "dff"
sense_amp = "sense_amp"
write_driver = "write_driver"
# Mapeia as células para usarem as versões GDS da PDK em vez dos geradores procedurais
inv_cell = "inv"      # Nome do arquivo inv.gds na gds_lib
nand2_cell = "nand2"  # Nome do arquivo nand2.gds na gds_lib
dff_cell = "dff"      # Nome do arquivo dff.gds na gds_lib

# 4. Desativa checagens LVS/DRC externas dentro da execução do Python se não tiver o Calibre instalado
check_lvsdrc = False

# 5. Desativa funções de ROM para não puxar PDKs genéricos
has_rom = False
