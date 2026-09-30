# ==============================================================================
# SDC CONSTRAINTS FOR SRAM 4_16_1RW (TSMC 65nm)
# ==============================================================================

# 1. Unidades Básicas
set_units -time ns -capacitance pF -resistance kOhm -voltage V -current mA

# 2. Definição do Clock Topo (ex: 200 MHz -> período de 5.0 ns)
create_clock -name clk0 -period 5.0 -waveform {0.0 2.5} [get_ports clk0]

# Uncerteza de relógio (Jitter + Skew esperado) e Transição das bordas
set_clock_uncertainty 0.200 [get_clocks clk0]
set_clock_transition  0.100 [get_clocks clk0]

# 3. Delays de Entrada (Inputs)
# Assumindo que os sinais chegam da lógica externa com uma margem de ~20% do ciclo de clock (1.0 ns)
set input_ports [get_ports {din0* addr0* csb0 web0}]

set_input_delay -clock clk0 -max 1.000 $input_ports
set_input_delay -clock clk0 -min 0.200 $input_ports

# Slews / Transição máxima de entrada esperada nos pinos
# set_driving_cell -lib_cell BUFX2_TSMC65 $input_ports
# Define um slew rate (tempo de transição) genérico de 100ps para as entradas
# Elimina a necessidade de especificar células da biblioteca como BUFX2
set_input_transition 0.100 $input_ports

# 4. Delays de Saída (Outputs)
# Exige que o dado lido (dout0) esteja estável e válido com folga antes da próxima borda
set output_ports [get_ports {dout0*}]

set_output_delay -clock clk0 -max 1.000 $output_ports
set_output_delay -clock clk0 -min 0.100 $output_ports

# Carga capacitiva estimada nas saídas (ex: pino externo ou entrada de reg)
set_load -pin_load 0.050 $output_ports