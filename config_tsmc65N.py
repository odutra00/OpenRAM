import os

# 1. Define a tecnologia TSMC 65nm
tech_name = "tsmc65N"

# Define o diretório de saída para os arquivos gerados
output_path = "output"

# (Opcional) Define o nome base do projeto/arquivos
output_name = "sram_4_16_1rw_tsmc65N"

# 2. Configurações da Memória (Ajuste a palavra e número de palavras)
num_words = 16
word_size = 4
words_per_row = 1
#words_per_row = 4  # Resulta em 256 x 128 (Razão de aspecto 2:1)
#words_per_row = 8  # Resulta em 128 x 256 (Razão de aspecto 1:2)
#write_size = 8  # Gera sinais de write-mask/byte-enable (ex: wmask[3:0] para dados de 32 bits)
# num_banks = 1 #dividir a memória inteira em blocos arquiteturais independentes (bancos) dentro do mesmo chip SRAM.

# ==============================================================================
# HABILITAÇÃO DE WRAPPERS E MÓDULOS CUSTOMIZADOS
# ==============================================================================
# 1. Ativa o uso de layouts estáticos e módulos customizados da tecnologia
use_cell_custom_layout = True

# 2. Instruções explícitas para o Precharger Customizado
precharge_module = "precharge" # Nome do arquivo precharge.py dentro de custom/
precharge_name = "precharge"   # Nome da célula dentro do seu precharge.gds

# 3. Mapeamento de Células Digitais Estáticas
# (Necessário - TEM QUE TER MESMO) para forçar o uso dos seus layouts e evitar geração procedural)
pinv_module = "pinv"
pinv_name = "pinv"
pnand2_module="pnand2"
pnand2_name = "pnand2"
pand2_module="pand2"
pand2_name = "pand2"
pand3_module="pand3"
pand3_name = "pand3"
dff_name = "dff"

# 4. Desativa checagens LVS/DRC externas dentro da execução do Python se não tiver o Calibre instalado
check_lvsdrc = False

# 5. Desativa funções de ROM para não puxar PDKs genéricos
has_rom = False
