**************************************************
* OpenRAM generated memory.
* Words: 16
* Data bits: 8
* Banks: 1
* Column mux: 1:1
* Trimmed: True
* LVS: False
**************************************************

.SUBCKT write_driver din bl br en vdd gnd
MMM_out0P2 bl en_bar int1 vdd pch l=60n w=360.0n m=1
MMM_out0P int1 bl_bar vdd vdd pch l=60n w=360.0n m=1
MMM_out1P2 br en_bar int3 vdd pch l=60n w=360.0n m=1
MMM_out1P int3 din vdd vdd pch l=60n w=360.0n m=1
MMM_inP bl_bar din vdd vdd pch l=60n w=360.0n m=1
MMM_outP en_bar en vdd vdd pch l=60n w=360.0n m=1
MMM_out0N2 int2 bl_bar gnd gnd nch l=60n w=180.0n m=1
MMM_out0N bl en int2 gnd nch l=60n w=180.0n m=1
MMM_out1N2 int4 din gnd gnd nch l=60n w=180.0n m=1
MMM_out1N br en int4 gnd nch l=60n w=180.0n m=1
MMM_inN bl_bar din gnd gnd nch l=60n w=180.0n m=1
MMM_outN en_bar en gnd gnd nch l=60n w=180.0n m=1
.ENDS write_driver

.SUBCKT sram_8b_16_1rw_tsmc65N_write_driver_array
+ data_0 data_1 data_2 data_3 data_4 data_5 data_6 data_7 bl_0 br_0 bl_1
+ br_1 bl_2 br_2 bl_3 br_3 bl_4 br_4 bl_5 br_5 bl_6 br_6 bl_7 br_7 en
+ vdd gnd
* INPUT : data_0 
* INPUT : data_1 
* INPUT : data_2 
* INPUT : data_3 
* INPUT : data_4 
* INPUT : data_5 
* INPUT : data_6 
* INPUT : data_7 
* OUTPUT: bl_0 
* OUTPUT: br_0 
* OUTPUT: bl_1 
* OUTPUT: br_1 
* OUTPUT: bl_2 
* OUTPUT: br_2 
* OUTPUT: bl_3 
* OUTPUT: br_3 
* OUTPUT: bl_4 
* OUTPUT: br_4 
* OUTPUT: bl_5 
* OUTPUT: br_5 
* OUTPUT: bl_6 
* OUTPUT: br_6 
* OUTPUT: bl_7 
* OUTPUT: br_7 
* INPUT : en 
* POWER : vdd 
* GROUND: gnd 
* columns: 8
* word_size 8
Xwrite_driver0
+ data_0 bl_0 br_0 en vdd gnd
+ write_driver
Xwrite_driver1
+ data_1 bl_1 br_1 en vdd gnd
+ write_driver
Xwrite_driver2
+ data_2 bl_2 br_2 en vdd gnd
+ write_driver
Xwrite_driver3
+ data_3 bl_3 br_3 en vdd gnd
+ write_driver
Xwrite_driver4
+ data_4 bl_4 br_4 en vdd gnd
+ write_driver
Xwrite_driver5
+ data_5 bl_5 br_5 en vdd gnd
+ write_driver
Xwrite_driver6
+ data_6 bl_6 br_6 en vdd gnd
+ write_driver
Xwrite_driver7
+ data_7 bl_7 br_7 en vdd gnd
+ write_driver
.ENDS sram_8b_16_1rw_tsmc65N_write_driver_array

.SUBCKT sense_amp bl br dout en vdd gnd

MMM11 dout dout_bar vdd vdd pch l=60n w=540.0n m=1
MMM9 dout_bar dint vdd vdd pch l=60n w=180.0n m=1
MMM1 dint net_1 vdd vdd pch l=60n w=540.0n m=1
MMM3 net_1 dint vdd vdd pch l=60n w=540.0n m=1
MMM5 bl en dint vdd pch l=60n w=720.0n m=1
MMM6 br en net_1 vdd pch l=60n w=720.0n m=1
MMM12 dout dout_bar gnd gnd nch l=60n w=270.0n m=1
MMM2 dint net_1 net_2 gnd nch l=60n w=270.0n m=1
MMM8 net_1 dint net_2 gnd nch l=60n w=270.0n m=1
MMM7 net_2 en gnd gnd nch l=60n w=270.0n m=1
MMM10 dout_bar dint gnd gnd nch l=60n w=120.0n m=1
.ENDS sense_amp


.SUBCKT sram_8b_16_1rw_tsmc65N_sense_amp_array
+ data_0 bl_0 br_0 data_1 bl_1 br_1 data_2 bl_2 br_2 data_3 bl_3 br_3
+ data_4 bl_4 br_4 data_5 bl_5 br_5 data_6 bl_6 br_6 data_7 bl_7 br_7 en
+ vdd gnd
* OUTPUT: data_0 
* INPUT : bl_0 
* INPUT : br_0 
* OUTPUT: data_1 
* INPUT : bl_1 
* INPUT : br_1 
* OUTPUT: data_2 
* INPUT : bl_2 
* INPUT : br_2 
* OUTPUT: data_3 
* INPUT : bl_3 
* INPUT : br_3 
* OUTPUT: data_4 
* INPUT : bl_4 
* INPUT : br_4 
* OUTPUT: data_5 
* INPUT : bl_5 
* INPUT : br_5 
* OUTPUT: data_6 
* INPUT : bl_6 
* INPUT : br_6 
* OUTPUT: data_7 
* INPUT : bl_7 
* INPUT : br_7 
* INPUT : en 
* POWER : vdd 
* GROUND: gnd 
* word_size 8
* words_per_row: 1
Xsa_d0
+ bl_0 br_0 data_0 en vdd gnd
+ sense_amp
Xsa_d1
+ bl_1 br_1 data_1 en vdd gnd
+ sense_amp
Xsa_d2
+ bl_2 br_2 data_2 en vdd gnd
+ sense_amp
Xsa_d3
+ bl_3 br_3 data_3 en vdd gnd
+ sense_amp
Xsa_d4
+ bl_4 br_4 data_4 en vdd gnd
+ sense_amp
Xsa_d5
+ bl_5 br_5 data_5 en vdd gnd
+ sense_amp
Xsa_d6
+ bl_6 br_6 data_6 en vdd gnd
+ sense_amp
Xsa_d7
+ bl_7 br_7 data_7 en vdd gnd
+ sense_amp
.ENDS sram_8b_16_1rw_tsmc65N_sense_amp_array

* spice ptx M{0} {1} pch m=1 w=0.0906u l=0.06u pd=0.30u ps=0.30u as=0.01p ad=0.01p

.SUBCKT sram_8b_16_1rw_tsmc65N_precharge_0
+ bl br en_bar vdd
* OUTPUT: bl 
* OUTPUT: br 
* INPUT : en_bar 
* POWER : vdd 
Mlower_pmos bl en_bar br vdd pch m=1 w=0.0906u l=0.06u pd=0.30u ps=0.30u as=0.01p ad=0.01p
Mupper_pmos1 bl en_bar vdd vdd pch m=1 w=0.0906u l=0.06u pd=0.30u ps=0.30u as=0.01p ad=0.01p
Mupper_pmos2 br en_bar vdd vdd pch m=1 w=0.0906u l=0.06u pd=0.30u ps=0.30u as=0.01p ad=0.01p
.ENDS sram_8b_16_1rw_tsmc65N_precharge_0

.SUBCKT sram_8b_16_1rw_tsmc65N_precharge_array
+ bl_0 br_0 bl_1 br_1 bl_2 br_2 bl_3 br_3 bl_4 br_4 bl_5 br_5 bl_6 br_6
+ bl_7 br_7 bl_8 br_8 en_bar vdd
* OUTPUT: bl_0 
* OUTPUT: br_0 
* OUTPUT: bl_1 
* OUTPUT: br_1 
* OUTPUT: bl_2 
* OUTPUT: br_2 
* OUTPUT: bl_3 
* OUTPUT: br_3 
* OUTPUT: bl_4 
* OUTPUT: br_4 
* OUTPUT: bl_5 
* OUTPUT: br_5 
* OUTPUT: bl_6 
* OUTPUT: br_6 
* OUTPUT: bl_7 
* OUTPUT: br_7 
* OUTPUT: bl_8 
* OUTPUT: br_8 
* INPUT : en_bar 
* POWER : vdd 
* cols: 9 size: 1 bl: bl br: br
Xpre_column_0
+ bl_0 br_0 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_1
+ bl_1 br_1 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_2
+ bl_2 br_2 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_3
+ bl_3 br_3 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_4
+ bl_4 br_4 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_5
+ bl_5 br_5 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_6
+ bl_6 br_6 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_7
+ bl_7 br_7 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
Xpre_column_8
+ bl_8 br_8 en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_0
.ENDS sram_8b_16_1rw_tsmc65N_precharge_array

.SUBCKT sram_8b_16_1rw_tsmc65N_port_data
+ rbl_bl rbl_br bl_0 br_0 bl_1 br_1 bl_2 br_2 bl_3 br_3 bl_4 br_4 bl_5
+ br_5 bl_6 br_6 bl_7 br_7 dout_0 dout_1 dout_2 dout_3 dout_4 dout_5
+ dout_6 dout_7 din_0 din_1 din_2 din_3 din_4 din_5 din_6 din_7 s_en
+ p_en_bar w_en vdd gnd
* INOUT : rbl_bl 
* INOUT : rbl_br 
* INOUT : bl_0 
* INOUT : br_0 
* INOUT : bl_1 
* INOUT : br_1 
* INOUT : bl_2 
* INOUT : br_2 
* INOUT : bl_3 
* INOUT : br_3 
* INOUT : bl_4 
* INOUT : br_4 
* INOUT : bl_5 
* INOUT : br_5 
* INOUT : bl_6 
* INOUT : br_6 
* INOUT : bl_7 
* INOUT : br_7 
* OUTPUT: dout_0 
* OUTPUT: dout_1 
* OUTPUT: dout_2 
* OUTPUT: dout_3 
* OUTPUT: dout_4 
* OUTPUT: dout_5 
* OUTPUT: dout_6 
* OUTPUT: dout_7 
* INPUT : din_0 
* INPUT : din_1 
* INPUT : din_2 
* INPUT : din_3 
* INPUT : din_4 
* INPUT : din_5 
* INPUT : din_6 
* INPUT : din_7 
* INPUT : s_en 
* INPUT : p_en_bar 
* INPUT : w_en 
* POWER : vdd 
* GROUND: gnd 
Xprecharge_array0
+ rbl_bl rbl_br bl_0 br_0 bl_1 br_1 bl_2 br_2 bl_3 br_3 bl_4 br_4 bl_5
+ br_5 bl_6 br_6 bl_7 br_7 p_en_bar vdd
+ sram_8b_16_1rw_tsmc65N_precharge_array
Xsense_amp_array0
+ dout_0 bl_0 br_0 dout_1 bl_1 br_1 dout_2 bl_2 br_2 dout_3 bl_3 br_3
+ dout_4 bl_4 br_4 dout_5 bl_5 br_5 dout_6 bl_6 br_6 dout_7 bl_7 br_7
+ s_en vdd gnd
+ sram_8b_16_1rw_tsmc65N_sense_amp_array
Xwrite_driver_array0
+ din_0 din_1 din_2 din_3 din_4 din_5 din_6 din_7 bl_0 br_0 bl_1 br_1
+ bl_2 br_2 bl_3 br_3 bl_4 br_4 bl_5 br_5 bl_6 br_6 bl_7 br_7 w_en vdd
+ gnd
+ sram_8b_16_1rw_tsmc65N_write_driver_array
.ENDS sram_8b_16_1rw_tsmc65N_port_data

.SUBCKT dummy_cell_1rw bl br wl vdd gnd
MMM3 bl wl Q gnd nch l=60n w=135.00n m=1
MMM2 br wl Q_bar gnd nch l=60n w=135.00n m=1
MMM0 Q_bar Q gnd gnd nch l=60n w=205.00n m=1
MMM1 Q Q_bar gnd gnd nch l=60n w=205.00n m=1
MMM4 Q_bar Q vdd vdd pch l=60n w=120.0n m=1
MMM5 Q Q_bar vdd vdd pch l=60n w=120.0n m=1
.ENDS dummy_cell_1rw


.SUBCKT sram_8b_16_1rw_tsmc65N_dummy_array_1
+ bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3 br_0_3 bl_0_4 br_0_4
+ bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 bl_0_8 br_0_8 wl_0_0 vdd gnd
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INOUT : bl_0_1 
* INOUT : br_0_1 
* INOUT : bl_0_2 
* INOUT : br_0_2 
* INOUT : bl_0_3 
* INOUT : br_0_3 
* INOUT : bl_0_4 
* INOUT : br_0_4 
* INOUT : bl_0_5 
* INOUT : br_0_5 
* INOUT : bl_0_6 
* INOUT : br_0_6 
* INOUT : bl_0_7 
* INOUT : br_0_7 
* INOUT : bl_0_8 
* INOUT : br_0_8 
* INPUT : wl_0_0 
* POWER : vdd 
* GROUND: gnd 
Xbit_r0_c0
+ bl_0_0 br_0_0 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c1
+ bl_0_1 br_0_1 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c2
+ bl_0_2 br_0_2 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c3
+ bl_0_3 br_0_3 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c4
+ bl_0_4 br_0_4 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c5
+ bl_0_5 br_0_5 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c6
+ bl_0_6 br_0_6 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c7
+ bl_0_7 br_0_7 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c8
+ bl_0_8 br_0_8 wl_0_0 vdd gnd
+ dummy_cell_1rw
.ENDS sram_8b_16_1rw_tsmc65N_dummy_array_1

.SUBCKT replica_cell_1rw bl br wl vdd gnd

MMM3 bl wl Q gnd nch l=60n w=135.00n m=1
MMM2 br wl Q_bar gnd nch l=60n w=135.00n m=1
MMM0 Q_bar Q gnd gnd nch l=60n w=205.00n m=1
MMM1 Q Q_bar gnd gnd nch l=60n w=205.00n m=1
MMM4 Q_bar Q vdd vdd pch l=60n w=120.0n m=1
MMM5 Q Q_bar vdd vdd pch l=60n w=120.0n m=1
.ENDS replica_cell_1rw


.SUBCKT sram_8b_16_1rw_tsmc65N_replica_column
+ bl_0_0 br_0_0 wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7
+ wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 wl_0_16
+ vdd gnd
* OUTPUT: bl_0_0 
* OUTPUT: br_0_0 
* INPUT : wl_0_0 
* INPUT : wl_0_1 
* INPUT : wl_0_2 
* INPUT : wl_0_3 
* INPUT : wl_0_4 
* INPUT : wl_0_5 
* INPUT : wl_0_6 
* INPUT : wl_0_7 
* INPUT : wl_0_8 
* INPUT : wl_0_9 
* INPUT : wl_0_10 
* INPUT : wl_0_11 
* INPUT : wl_0_12 
* INPUT : wl_0_13 
* INPUT : wl_0_14 
* INPUT : wl_0_15 
* INPUT : wl_0_16 
* POWER : vdd 
* GROUND: gnd 
Xrbc_0
+ bl_0_0 br_0_0 wl_0_0 vdd gnd
+ replica_cell_1rw
Xrbc_1
+ bl_0_0 br_0_0 wl_0_1 vdd gnd
+ replica_cell_1rw
Xrbc_2
+ bl_0_0 br_0_0 wl_0_2 vdd gnd
+ replica_cell_1rw
Xrbc_3
+ bl_0_0 br_0_0 wl_0_3 vdd gnd
+ replica_cell_1rw
Xrbc_4
+ bl_0_0 br_0_0 wl_0_4 vdd gnd
+ replica_cell_1rw
Xrbc_5
+ bl_0_0 br_0_0 wl_0_5 vdd gnd
+ replica_cell_1rw
Xrbc_6
+ bl_0_0 br_0_0 wl_0_6 vdd gnd
+ replica_cell_1rw
Xrbc_7
+ bl_0_0 br_0_0 wl_0_7 vdd gnd
+ replica_cell_1rw
Xrbc_8
+ bl_0_0 br_0_0 wl_0_8 vdd gnd
+ replica_cell_1rw
Xrbc_9
+ bl_0_0 br_0_0 wl_0_9 vdd gnd
+ replica_cell_1rw
Xrbc_10
+ bl_0_0 br_0_0 wl_0_10 vdd gnd
+ replica_cell_1rw
Xrbc_11
+ bl_0_0 br_0_0 wl_0_11 vdd gnd
+ replica_cell_1rw
Xrbc_12
+ bl_0_0 br_0_0 wl_0_12 vdd gnd
+ replica_cell_1rw
Xrbc_13
+ bl_0_0 br_0_0 wl_0_13 vdd gnd
+ replica_cell_1rw
Xrbc_14
+ bl_0_0 br_0_0 wl_0_14 vdd gnd
+ replica_cell_1rw
Xrbc_15
+ bl_0_0 br_0_0 wl_0_15 vdd gnd
+ replica_cell_1rw
Xrbc_16
+ bl_0_0 br_0_0 wl_0_16 vdd gnd
+ replica_cell_1rw
.ENDS sram_8b_16_1rw_tsmc65N_replica_column

.SUBCKT cell_1rw bl br wl vdd gnd

MMM3 bl wl Q gnd nch l=60n w=135.00n m=1
MMM2 br wl Q_bar gnd nch l=60n w=135.00n m=1
MMM0 Q_bar Q gnd gnd nch l=60n w=205.00n m=1
MMM1 Q Q_bar gnd gnd nch l=60n w=205.00n m=1
MMM4 Q_bar Q vdd vdd pch l=60n w=120.0n m=1
MMM5 Q Q_bar vdd vdd pch l=60n w=120.0n m=1
.ENDS cell_1rw


.SUBCKT sram_8b_16_1rw_tsmc65N_bitcell_array
+ bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3 br_0_3 bl_0_4 br_0_4
+ bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 wl_0_0 wl_0_1 wl_0_2 wl_0_3
+ wl_0_4 wl_0_5 wl_0_6 wl_0_7 wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12
+ wl_0_13 wl_0_14 wl_0_15 vdd gnd
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INOUT : bl_0_1 
* INOUT : br_0_1 
* INOUT : bl_0_2 
* INOUT : br_0_2 
* INOUT : bl_0_3 
* INOUT : br_0_3 
* INOUT : bl_0_4 
* INOUT : br_0_4 
* INOUT : bl_0_5 
* INOUT : br_0_5 
* INOUT : bl_0_6 
* INOUT : br_0_6 
* INOUT : bl_0_7 
* INOUT : br_0_7 
* INPUT : wl_0_0 
* INPUT : wl_0_1 
* INPUT : wl_0_2 
* INPUT : wl_0_3 
* INPUT : wl_0_4 
* INPUT : wl_0_5 
* INPUT : wl_0_6 
* INPUT : wl_0_7 
* INPUT : wl_0_8 
* INPUT : wl_0_9 
* INPUT : wl_0_10 
* INPUT : wl_0_11 
* INPUT : wl_0_12 
* INPUT : wl_0_13 
* INPUT : wl_0_14 
* INPUT : wl_0_15 
* POWER : vdd 
* GROUND: gnd 
* rows: 16 cols: 8
Xbit_r0_c0
+ bl_0_0 br_0_0 wl_0_0 vdd gnd
+ cell_1rw
Xbit_r1_c0
+ bl_0_0 br_0_0 wl_0_1 vdd gnd
+ cell_1rw
Xbit_r2_c0
+ bl_0_0 br_0_0 wl_0_2 vdd gnd
+ cell_1rw
Xbit_r3_c0
+ bl_0_0 br_0_0 wl_0_3 vdd gnd
+ cell_1rw
Xbit_r4_c0
+ bl_0_0 br_0_0 wl_0_4 vdd gnd
+ cell_1rw
Xbit_r5_c0
+ bl_0_0 br_0_0 wl_0_5 vdd gnd
+ cell_1rw
Xbit_r6_c0
+ bl_0_0 br_0_0 wl_0_6 vdd gnd
+ cell_1rw
Xbit_r7_c0
+ bl_0_0 br_0_0 wl_0_7 vdd gnd
+ cell_1rw
Xbit_r8_c0
+ bl_0_0 br_0_0 wl_0_8 vdd gnd
+ cell_1rw
Xbit_r9_c0
+ bl_0_0 br_0_0 wl_0_9 vdd gnd
+ cell_1rw
Xbit_r10_c0
+ bl_0_0 br_0_0 wl_0_10 vdd gnd
+ cell_1rw
Xbit_r11_c0
+ bl_0_0 br_0_0 wl_0_11 vdd gnd
+ cell_1rw
Xbit_r12_c0
+ bl_0_0 br_0_0 wl_0_12 vdd gnd
+ cell_1rw
Xbit_r13_c0
+ bl_0_0 br_0_0 wl_0_13 vdd gnd
+ cell_1rw
Xbit_r14_c0
+ bl_0_0 br_0_0 wl_0_14 vdd gnd
+ cell_1rw
Xbit_r15_c0
+ bl_0_0 br_0_0 wl_0_15 vdd gnd
+ cell_1rw
Xbit_r0_c1
+ bl_0_1 br_0_1 wl_0_0 vdd gnd
+ cell_1rw
* Xbit_r1_c1
*+ bl_0_1 br_0_1 wl_0_1 vdd gnd
*+ cell_1rw
* Xbit_r2_c1
*+ bl_0_1 br_0_1 wl_0_2 vdd gnd
*+ cell_1rw
* Xbit_r3_c1
*+ bl_0_1 br_0_1 wl_0_3 vdd gnd
*+ cell_1rw
* Xbit_r4_c1
*+ bl_0_1 br_0_1 wl_0_4 vdd gnd
*+ cell_1rw
* Xbit_r5_c1
*+ bl_0_1 br_0_1 wl_0_5 vdd gnd
*+ cell_1rw
* Xbit_r6_c1
*+ bl_0_1 br_0_1 wl_0_6 vdd gnd
*+ cell_1rw
* Xbit_r7_c1
*+ bl_0_1 br_0_1 wl_0_7 vdd gnd
*+ cell_1rw
* Xbit_r8_c1
*+ bl_0_1 br_0_1 wl_0_8 vdd gnd
*+ cell_1rw
* Xbit_r9_c1
*+ bl_0_1 br_0_1 wl_0_9 vdd gnd
*+ cell_1rw
* Xbit_r10_c1
*+ bl_0_1 br_0_1 wl_0_10 vdd gnd
*+ cell_1rw
* Xbit_r11_c1
*+ bl_0_1 br_0_1 wl_0_11 vdd gnd
*+ cell_1rw
* Xbit_r12_c1
*+ bl_0_1 br_0_1 wl_0_12 vdd gnd
*+ cell_1rw
* Xbit_r13_c1
*+ bl_0_1 br_0_1 wl_0_13 vdd gnd
*+ cell_1rw
* Xbit_r14_c1
*+ bl_0_1 br_0_1 wl_0_14 vdd gnd
*+ cell_1rw
Xbit_r15_c1
+ bl_0_1 br_0_1 wl_0_15 vdd gnd
+ cell_1rw
Xbit_r0_c2
+ bl_0_2 br_0_2 wl_0_0 vdd gnd
+ cell_1rw
* Xbit_r1_c2
*+ bl_0_2 br_0_2 wl_0_1 vdd gnd
*+ cell_1rw
* Xbit_r2_c2
*+ bl_0_2 br_0_2 wl_0_2 vdd gnd
*+ cell_1rw
* Xbit_r3_c2
*+ bl_0_2 br_0_2 wl_0_3 vdd gnd
*+ cell_1rw
* Xbit_r4_c2
*+ bl_0_2 br_0_2 wl_0_4 vdd gnd
*+ cell_1rw
* Xbit_r5_c2
*+ bl_0_2 br_0_2 wl_0_5 vdd gnd
*+ cell_1rw
* Xbit_r6_c2
*+ bl_0_2 br_0_2 wl_0_6 vdd gnd
*+ cell_1rw
* Xbit_r7_c2
*+ bl_0_2 br_0_2 wl_0_7 vdd gnd
*+ cell_1rw
* Xbit_r8_c2
*+ bl_0_2 br_0_2 wl_0_8 vdd gnd
*+ cell_1rw
* Xbit_r9_c2
*+ bl_0_2 br_0_2 wl_0_9 vdd gnd
*+ cell_1rw
* Xbit_r10_c2
*+ bl_0_2 br_0_2 wl_0_10 vdd gnd
*+ cell_1rw
* Xbit_r11_c2
*+ bl_0_2 br_0_2 wl_0_11 vdd gnd
*+ cell_1rw
* Xbit_r12_c2
*+ bl_0_2 br_0_2 wl_0_12 vdd gnd
*+ cell_1rw
* Xbit_r13_c2
*+ bl_0_2 br_0_2 wl_0_13 vdd gnd
*+ cell_1rw
* Xbit_r14_c2
*+ bl_0_2 br_0_2 wl_0_14 vdd gnd
*+ cell_1rw
Xbit_r15_c2
+ bl_0_2 br_0_2 wl_0_15 vdd gnd
+ cell_1rw
Xbit_r0_c3
+ bl_0_3 br_0_3 wl_0_0 vdd gnd
+ cell_1rw
* Xbit_r1_c3
*+ bl_0_3 br_0_3 wl_0_1 vdd gnd
*+ cell_1rw
* Xbit_r2_c3
*+ bl_0_3 br_0_3 wl_0_2 vdd gnd
*+ cell_1rw
* Xbit_r3_c3
*+ bl_0_3 br_0_3 wl_0_3 vdd gnd
*+ cell_1rw
* Xbit_r4_c3
*+ bl_0_3 br_0_3 wl_0_4 vdd gnd
*+ cell_1rw
* Xbit_r5_c3
*+ bl_0_3 br_0_3 wl_0_5 vdd gnd
*+ cell_1rw
* Xbit_r6_c3
*+ bl_0_3 br_0_3 wl_0_6 vdd gnd
*+ cell_1rw
* Xbit_r7_c3
*+ bl_0_3 br_0_3 wl_0_7 vdd gnd
*+ cell_1rw
* Xbit_r8_c3
*+ bl_0_3 br_0_3 wl_0_8 vdd gnd
*+ cell_1rw
* Xbit_r9_c3
*+ bl_0_3 br_0_3 wl_0_9 vdd gnd
*+ cell_1rw
* Xbit_r10_c3
*+ bl_0_3 br_0_3 wl_0_10 vdd gnd
*+ cell_1rw
* Xbit_r11_c3
*+ bl_0_3 br_0_3 wl_0_11 vdd gnd
*+ cell_1rw
* Xbit_r12_c3
*+ bl_0_3 br_0_3 wl_0_12 vdd gnd
*+ cell_1rw
* Xbit_r13_c3
*+ bl_0_3 br_0_3 wl_0_13 vdd gnd
*+ cell_1rw
* Xbit_r14_c3
*+ bl_0_3 br_0_3 wl_0_14 vdd gnd
*+ cell_1rw
Xbit_r15_c3
+ bl_0_3 br_0_3 wl_0_15 vdd gnd
+ cell_1rw
Xbit_r0_c4
+ bl_0_4 br_0_4 wl_0_0 vdd gnd
+ cell_1rw
* Xbit_r1_c4
*+ bl_0_4 br_0_4 wl_0_1 vdd gnd
*+ cell_1rw
* Xbit_r2_c4
*+ bl_0_4 br_0_4 wl_0_2 vdd gnd
*+ cell_1rw
* Xbit_r3_c4
*+ bl_0_4 br_0_4 wl_0_3 vdd gnd
*+ cell_1rw
* Xbit_r4_c4
*+ bl_0_4 br_0_4 wl_0_4 vdd gnd
*+ cell_1rw
* Xbit_r5_c4
*+ bl_0_4 br_0_4 wl_0_5 vdd gnd
*+ cell_1rw
* Xbit_r6_c4
*+ bl_0_4 br_0_4 wl_0_6 vdd gnd
*+ cell_1rw
* Xbit_r7_c4
*+ bl_0_4 br_0_4 wl_0_7 vdd gnd
*+ cell_1rw
* Xbit_r8_c4
*+ bl_0_4 br_0_4 wl_0_8 vdd gnd
*+ cell_1rw
* Xbit_r9_c4
*+ bl_0_4 br_0_4 wl_0_9 vdd gnd
*+ cell_1rw
* Xbit_r10_c4
*+ bl_0_4 br_0_4 wl_0_10 vdd gnd
*+ cell_1rw
* Xbit_r11_c4
*+ bl_0_4 br_0_4 wl_0_11 vdd gnd
*+ cell_1rw
* Xbit_r12_c4
*+ bl_0_4 br_0_4 wl_0_12 vdd gnd
*+ cell_1rw
* Xbit_r13_c4
*+ bl_0_4 br_0_4 wl_0_13 vdd gnd
*+ cell_1rw
* Xbit_r14_c4
*+ bl_0_4 br_0_4 wl_0_14 vdd gnd
*+ cell_1rw
Xbit_r15_c4
+ bl_0_4 br_0_4 wl_0_15 vdd gnd
+ cell_1rw
Xbit_r0_c5
+ bl_0_5 br_0_5 wl_0_0 vdd gnd
+ cell_1rw
* Xbit_r1_c5
*+ bl_0_5 br_0_5 wl_0_1 vdd gnd
*+ cell_1rw
* Xbit_r2_c5
*+ bl_0_5 br_0_5 wl_0_2 vdd gnd
*+ cell_1rw
* Xbit_r3_c5
*+ bl_0_5 br_0_5 wl_0_3 vdd gnd
*+ cell_1rw
* Xbit_r4_c5
*+ bl_0_5 br_0_5 wl_0_4 vdd gnd
*+ cell_1rw
* Xbit_r5_c5
*+ bl_0_5 br_0_5 wl_0_5 vdd gnd
*+ cell_1rw
* Xbit_r6_c5
*+ bl_0_5 br_0_5 wl_0_6 vdd gnd
*+ cell_1rw
* Xbit_r7_c5
*+ bl_0_5 br_0_5 wl_0_7 vdd gnd
*+ cell_1rw
* Xbit_r8_c5
*+ bl_0_5 br_0_5 wl_0_8 vdd gnd
*+ cell_1rw
* Xbit_r9_c5
*+ bl_0_5 br_0_5 wl_0_9 vdd gnd
*+ cell_1rw
* Xbit_r10_c5
*+ bl_0_5 br_0_5 wl_0_10 vdd gnd
*+ cell_1rw
* Xbit_r11_c5
*+ bl_0_5 br_0_5 wl_0_11 vdd gnd
*+ cell_1rw
* Xbit_r12_c5
*+ bl_0_5 br_0_5 wl_0_12 vdd gnd
*+ cell_1rw
* Xbit_r13_c5
*+ bl_0_5 br_0_5 wl_0_13 vdd gnd
*+ cell_1rw
* Xbit_r14_c5
*+ bl_0_5 br_0_5 wl_0_14 vdd gnd
*+ cell_1rw
Xbit_r15_c5
+ bl_0_5 br_0_5 wl_0_15 vdd gnd
+ cell_1rw
Xbit_r0_c6
+ bl_0_6 br_0_6 wl_0_0 vdd gnd
+ cell_1rw
* Xbit_r1_c6
*+ bl_0_6 br_0_6 wl_0_1 vdd gnd
*+ cell_1rw
* Xbit_r2_c6
*+ bl_0_6 br_0_6 wl_0_2 vdd gnd
*+ cell_1rw
* Xbit_r3_c6
*+ bl_0_6 br_0_6 wl_0_3 vdd gnd
*+ cell_1rw
* Xbit_r4_c6
*+ bl_0_6 br_0_6 wl_0_4 vdd gnd
*+ cell_1rw
* Xbit_r5_c6
*+ bl_0_6 br_0_6 wl_0_5 vdd gnd
*+ cell_1rw
* Xbit_r6_c6
*+ bl_0_6 br_0_6 wl_0_6 vdd gnd
*+ cell_1rw
* Xbit_r7_c6
*+ bl_0_6 br_0_6 wl_0_7 vdd gnd
*+ cell_1rw
* Xbit_r8_c6
*+ bl_0_6 br_0_6 wl_0_8 vdd gnd
*+ cell_1rw
* Xbit_r9_c6
*+ bl_0_6 br_0_6 wl_0_9 vdd gnd
*+ cell_1rw
* Xbit_r10_c6
*+ bl_0_6 br_0_6 wl_0_10 vdd gnd
*+ cell_1rw
* Xbit_r11_c6
*+ bl_0_6 br_0_6 wl_0_11 vdd gnd
*+ cell_1rw
* Xbit_r12_c6
*+ bl_0_6 br_0_6 wl_0_12 vdd gnd
*+ cell_1rw
* Xbit_r13_c6
*+ bl_0_6 br_0_6 wl_0_13 vdd gnd
*+ cell_1rw
* Xbit_r14_c6
*+ bl_0_6 br_0_6 wl_0_14 vdd gnd
*+ cell_1rw
Xbit_r15_c6
+ bl_0_6 br_0_6 wl_0_15 vdd gnd
+ cell_1rw
Xbit_r0_c7
+ bl_0_7 br_0_7 wl_0_0 vdd gnd
+ cell_1rw
Xbit_r1_c7
+ bl_0_7 br_0_7 wl_0_1 vdd gnd
+ cell_1rw
Xbit_r2_c7
+ bl_0_7 br_0_7 wl_0_2 vdd gnd
+ cell_1rw
Xbit_r3_c7
+ bl_0_7 br_0_7 wl_0_3 vdd gnd
+ cell_1rw
Xbit_r4_c7
+ bl_0_7 br_0_7 wl_0_4 vdd gnd
+ cell_1rw
Xbit_r5_c7
+ bl_0_7 br_0_7 wl_0_5 vdd gnd
+ cell_1rw
Xbit_r6_c7
+ bl_0_7 br_0_7 wl_0_6 vdd gnd
+ cell_1rw
Xbit_r7_c7
+ bl_0_7 br_0_7 wl_0_7 vdd gnd
+ cell_1rw
Xbit_r8_c7
+ bl_0_7 br_0_7 wl_0_8 vdd gnd
+ cell_1rw
Xbit_r9_c7
+ bl_0_7 br_0_7 wl_0_9 vdd gnd
+ cell_1rw
Xbit_r10_c7
+ bl_0_7 br_0_7 wl_0_10 vdd gnd
+ cell_1rw
Xbit_r11_c7
+ bl_0_7 br_0_7 wl_0_11 vdd gnd
+ cell_1rw
Xbit_r12_c7
+ bl_0_7 br_0_7 wl_0_12 vdd gnd
+ cell_1rw
Xbit_r13_c7
+ bl_0_7 br_0_7 wl_0_13 vdd gnd
+ cell_1rw
Xbit_r14_c7
+ bl_0_7 br_0_7 wl_0_14 vdd gnd
+ cell_1rw
Xbit_r15_c7
+ bl_0_7 br_0_7 wl_0_15 vdd gnd
+ cell_1rw
.ENDS sram_8b_16_1rw_tsmc65N_bitcell_array

.SUBCKT sram_8b_16_1rw_tsmc65N_dummy_array
+ bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3 br_0_3 bl_0_4 br_0_4
+ bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 wl_0_0 vdd gnd
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INOUT : bl_0_1 
* INOUT : br_0_1 
* INOUT : bl_0_2 
* INOUT : br_0_2 
* INOUT : bl_0_3 
* INOUT : br_0_3 
* INOUT : bl_0_4 
* INOUT : br_0_4 
* INOUT : bl_0_5 
* INOUT : br_0_5 
* INOUT : bl_0_6 
* INOUT : br_0_6 
* INOUT : bl_0_7 
* INOUT : br_0_7 
* INPUT : wl_0_0 
* POWER : vdd 
* GROUND: gnd 
Xbit_r0_c0
+ bl_0_0 br_0_0 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c1
+ bl_0_1 br_0_1 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c2
+ bl_0_2 br_0_2 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c3
+ bl_0_3 br_0_3 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c4
+ bl_0_4 br_0_4 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c5
+ bl_0_5 br_0_5 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c6
+ bl_0_6 br_0_6 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c7
+ bl_0_7 br_0_7 wl_0_0 vdd gnd
+ dummy_cell_1rw
.ENDS sram_8b_16_1rw_tsmc65N_dummy_array

.SUBCKT sram_8b_16_1rw_tsmc65N_replica_bitcell_array
+ rbl_bl_0_0 rbl_br_0_0 bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3
+ br_0_3 bl_0_4 br_0_4 bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7
+ rbl_wl_0_0 wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7
+ wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 vdd gnd
* INOUT : rbl_bl_0_0 
* INOUT : rbl_br_0_0 
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INOUT : bl_0_1 
* INOUT : br_0_1 
* INOUT : bl_0_2 
* INOUT : br_0_2 
* INOUT : bl_0_3 
* INOUT : br_0_3 
* INOUT : bl_0_4 
* INOUT : br_0_4 
* INOUT : bl_0_5 
* INOUT : br_0_5 
* INOUT : bl_0_6 
* INOUT : br_0_6 
* INOUT : bl_0_7 
* INOUT : br_0_7 
* INPUT : rbl_wl_0_0 
* INPUT : wl_0_0 
* INPUT : wl_0_1 
* INPUT : wl_0_2 
* INPUT : wl_0_3 
* INPUT : wl_0_4 
* INPUT : wl_0_5 
* INPUT : wl_0_6 
* INPUT : wl_0_7 
* INPUT : wl_0_8 
* INPUT : wl_0_9 
* INPUT : wl_0_10 
* INPUT : wl_0_11 
* INPUT : wl_0_12 
* INPUT : wl_0_13 
* INPUT : wl_0_14 
* INPUT : wl_0_15 
* POWER : vdd 
* GROUND: gnd 
* rows: 16 cols: 8
* rbl: [1, 0] left_rbl: [0] right_rbl: []
Xbitcell_array
+ bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3 br_0_3 bl_0_4 br_0_4
+ bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 wl_0_0 wl_0_1 wl_0_2 wl_0_3
+ wl_0_4 wl_0_5 wl_0_6 wl_0_7 wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12
+ wl_0_13 wl_0_14 wl_0_15 vdd gnd
+ sram_8b_16_1rw_tsmc65N_bitcell_array
Xreplica_col_0
+ rbl_bl_0_0 rbl_br_0_0 rbl_wl_0_0 wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4
+ wl_0_5 wl_0_6 wl_0_7 wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12 wl_0_13
+ wl_0_14 wl_0_15 vdd gnd
+ sram_8b_16_1rw_tsmc65N_replica_column
Xdummy_row_0
+ bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3 br_0_3 bl_0_4 br_0_4
+ bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 rbl_wl_0_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_dummy_array
.ENDS sram_8b_16_1rw_tsmc65N_replica_bitcell_array

.SUBCKT sram_8b_16_1rw_tsmc65N_dummy_array_0
+ bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3 br_0_3 bl_0_4 br_0_4
+ bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 bl_0_8 br_0_8 wl_0_0 vdd gnd
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INOUT : bl_0_1 
* INOUT : br_0_1 
* INOUT : bl_0_2 
* INOUT : br_0_2 
* INOUT : bl_0_3 
* INOUT : br_0_3 
* INOUT : bl_0_4 
* INOUT : br_0_4 
* INOUT : bl_0_5 
* INOUT : br_0_5 
* INOUT : bl_0_6 
* INOUT : br_0_6 
* INOUT : bl_0_7 
* INOUT : br_0_7 
* INOUT : bl_0_8 
* INOUT : br_0_8 
* INPUT : wl_0_0 
* POWER : vdd 
* GROUND: gnd 
Xbit_r0_c0
+ bl_0_0 br_0_0 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c1
+ bl_0_1 br_0_1 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c2
+ bl_0_2 br_0_2 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c3
+ bl_0_3 br_0_3 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c4
+ bl_0_4 br_0_4 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c5
+ bl_0_5 br_0_5 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c6
+ bl_0_6 br_0_6 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c7
+ bl_0_7 br_0_7 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r0_c8
+ bl_0_8 br_0_8 wl_0_0 vdd gnd
+ dummy_cell_1rw
.ENDS sram_8b_16_1rw_tsmc65N_dummy_array_0

.SUBCKT sram_8b_16_1rw_tsmc65N_dummy_array_2
+ bl_0_0 br_0_0 wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7
+ wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 wl_0_16
+ wl_0_17 wl_0_18 vdd gnd
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INPUT : wl_0_0 
* INPUT : wl_0_1 
* INPUT : wl_0_2 
* INPUT : wl_0_3 
* INPUT : wl_0_4 
* INPUT : wl_0_5 
* INPUT : wl_0_6 
* INPUT : wl_0_7 
* INPUT : wl_0_8 
* INPUT : wl_0_9 
* INPUT : wl_0_10 
* INPUT : wl_0_11 
* INPUT : wl_0_12 
* INPUT : wl_0_13 
* INPUT : wl_0_14 
* INPUT : wl_0_15 
* INPUT : wl_0_16 
* INPUT : wl_0_17 
* INPUT : wl_0_18 
* POWER : vdd 
* GROUND: gnd 
Xbit_r0_c0
+ bl_0_0 br_0_0 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r1_c0
+ bl_0_0 br_0_0 wl_0_1 vdd gnd
+ dummy_cell_1rw
Xbit_r2_c0
+ bl_0_0 br_0_0 wl_0_2 vdd gnd
+ dummy_cell_1rw
Xbit_r3_c0
+ bl_0_0 br_0_0 wl_0_3 vdd gnd
+ dummy_cell_1rw
Xbit_r4_c0
+ bl_0_0 br_0_0 wl_0_4 vdd gnd
+ dummy_cell_1rw
Xbit_r5_c0
+ bl_0_0 br_0_0 wl_0_5 vdd gnd
+ dummy_cell_1rw
Xbit_r6_c0
+ bl_0_0 br_0_0 wl_0_6 vdd gnd
+ dummy_cell_1rw
Xbit_r7_c0
+ bl_0_0 br_0_0 wl_0_7 vdd gnd
+ dummy_cell_1rw
Xbit_r8_c0
+ bl_0_0 br_0_0 wl_0_8 vdd gnd
+ dummy_cell_1rw
Xbit_r9_c0
+ bl_0_0 br_0_0 wl_0_9 vdd gnd
+ dummy_cell_1rw
Xbit_r10_c0
+ bl_0_0 br_0_0 wl_0_10 vdd gnd
+ dummy_cell_1rw
Xbit_r11_c0
+ bl_0_0 br_0_0 wl_0_11 vdd gnd
+ dummy_cell_1rw
Xbit_r12_c0
+ bl_0_0 br_0_0 wl_0_12 vdd gnd
+ dummy_cell_1rw
Xbit_r13_c0
+ bl_0_0 br_0_0 wl_0_13 vdd gnd
+ dummy_cell_1rw
Xbit_r14_c0
+ bl_0_0 br_0_0 wl_0_14 vdd gnd
+ dummy_cell_1rw
Xbit_r15_c0
+ bl_0_0 br_0_0 wl_0_15 vdd gnd
+ dummy_cell_1rw
Xbit_r16_c0
+ bl_0_0 br_0_0 wl_0_16 vdd gnd
+ dummy_cell_1rw
Xbit_r17_c0
+ bl_0_0 br_0_0 wl_0_17 vdd gnd
+ dummy_cell_1rw
Xbit_r18_c0
+ bl_0_0 br_0_0 wl_0_18 vdd gnd
+ dummy_cell_1rw
.ENDS sram_8b_16_1rw_tsmc65N_dummy_array_2

.SUBCKT sram_8b_16_1rw_tsmc65N_dummy_array_3
+ bl_0_0 br_0_0 wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7
+ wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 wl_0_16
+ wl_0_17 wl_0_18 vdd gnd
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INPUT : wl_0_0 
* INPUT : wl_0_1 
* INPUT : wl_0_2 
* INPUT : wl_0_3 
* INPUT : wl_0_4 
* INPUT : wl_0_5 
* INPUT : wl_0_6 
* INPUT : wl_0_7 
* INPUT : wl_0_8 
* INPUT : wl_0_9 
* INPUT : wl_0_10 
* INPUT : wl_0_11 
* INPUT : wl_0_12 
* INPUT : wl_0_13 
* INPUT : wl_0_14 
* INPUT : wl_0_15 
* INPUT : wl_0_16 
* INPUT : wl_0_17 
* INPUT : wl_0_18 
* POWER : vdd 
* GROUND: gnd 
Xbit_r0_c0
+ bl_0_0 br_0_0 wl_0_0 vdd gnd
+ dummy_cell_1rw
Xbit_r1_c0
+ bl_0_0 br_0_0 wl_0_1 vdd gnd
+ dummy_cell_1rw
Xbit_r2_c0
+ bl_0_0 br_0_0 wl_0_2 vdd gnd
+ dummy_cell_1rw
Xbit_r3_c0
+ bl_0_0 br_0_0 wl_0_3 vdd gnd
+ dummy_cell_1rw
Xbit_r4_c0
+ bl_0_0 br_0_0 wl_0_4 vdd gnd
+ dummy_cell_1rw
Xbit_r5_c0
+ bl_0_0 br_0_0 wl_0_5 vdd gnd
+ dummy_cell_1rw
Xbit_r6_c0
+ bl_0_0 br_0_0 wl_0_6 vdd gnd
+ dummy_cell_1rw
Xbit_r7_c0
+ bl_0_0 br_0_0 wl_0_7 vdd gnd
+ dummy_cell_1rw
Xbit_r8_c0
+ bl_0_0 br_0_0 wl_0_8 vdd gnd
+ dummy_cell_1rw
Xbit_r9_c0
+ bl_0_0 br_0_0 wl_0_9 vdd gnd
+ dummy_cell_1rw
Xbit_r10_c0
+ bl_0_0 br_0_0 wl_0_10 vdd gnd
+ dummy_cell_1rw
Xbit_r11_c0
+ bl_0_0 br_0_0 wl_0_11 vdd gnd
+ dummy_cell_1rw
Xbit_r12_c0
+ bl_0_0 br_0_0 wl_0_12 vdd gnd
+ dummy_cell_1rw
Xbit_r13_c0
+ bl_0_0 br_0_0 wl_0_13 vdd gnd
+ dummy_cell_1rw
Xbit_r14_c0
+ bl_0_0 br_0_0 wl_0_14 vdd gnd
+ dummy_cell_1rw
Xbit_r15_c0
+ bl_0_0 br_0_0 wl_0_15 vdd gnd
+ dummy_cell_1rw
Xbit_r16_c0
+ bl_0_0 br_0_0 wl_0_16 vdd gnd
+ dummy_cell_1rw
Xbit_r17_c0
+ bl_0_0 br_0_0 wl_0_17 vdd gnd
+ dummy_cell_1rw
Xbit_r18_c0
+ bl_0_0 br_0_0 wl_0_18 vdd gnd
+ dummy_cell_1rw
.ENDS sram_8b_16_1rw_tsmc65N_dummy_array_3

.SUBCKT sram_8b_16_1rw_tsmc65N_capped_replica_bitcell_array
+ rbl_bl_0_0 rbl_br_0_0 bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3
+ br_0_3 bl_0_4 br_0_4 bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7
+ rbl_wl_0_0 wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7
+ wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 vdd gnd
* INOUT : rbl_bl_0_0 
* INOUT : rbl_br_0_0 
* INOUT : bl_0_0 
* INOUT : br_0_0 
* INOUT : bl_0_1 
* INOUT : br_0_1 
* INOUT : bl_0_2 
* INOUT : br_0_2 
* INOUT : bl_0_3 
* INOUT : br_0_3 
* INOUT : bl_0_4 
* INOUT : br_0_4 
* INOUT : bl_0_5 
* INOUT : br_0_5 
* INOUT : bl_0_6 
* INOUT : br_0_6 
* INOUT : bl_0_7 
* INOUT : br_0_7 
* INPUT : rbl_wl_0_0 
* INPUT : wl_0_0 
* INPUT : wl_0_1 
* INPUT : wl_0_2 
* INPUT : wl_0_3 
* INPUT : wl_0_4 
* INPUT : wl_0_5 
* INPUT : wl_0_6 
* INPUT : wl_0_7 
* INPUT : wl_0_8 
* INPUT : wl_0_9 
* INPUT : wl_0_10 
* INPUT : wl_0_11 
* INPUT : wl_0_12 
* INPUT : wl_0_13 
* INPUT : wl_0_14 
* INPUT : wl_0_15 
* POWER : vdd 
* GROUND: gnd 
* rows: 16 cols: 8
* rbl: [1, 0] left_rbl: [0] right_rbl: []
Xreplica_bitcell_array
+ rbl_bl_0_0 rbl_br_0_0 bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3
+ br_0_3 bl_0_4 br_0_4 bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7
+ rbl_wl_0_0 wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7
+ wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 vdd gnd
+ sram_8b_16_1rw_tsmc65N_replica_bitcell_array
Xdummy_row_bot
+ rbl_bl_0_0 rbl_br_0_0 bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3
+ br_0_3 bl_0_4 br_0_4 bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 gnd vdd
+ gnd
+ sram_8b_16_1rw_tsmc65N_dummy_array_1
Xdummy_row_top
+ rbl_bl_0_0 rbl_br_0_0 bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3
+ br_0_3 bl_0_4 br_0_4 bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 gnd vdd
+ gnd
+ sram_8b_16_1rw_tsmc65N_dummy_array_0
Xdummy_col_left
+ dummy_left_bl_0_0 dummy_left_br_0_0 gnd rbl_wl_0_0 wl_0_0 wl_0_1
+ wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7 wl_0_8 wl_0_9 wl_0_10
+ wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 gnd vdd gnd
+ sram_8b_16_1rw_tsmc65N_dummy_array_2
Xdummy_col_right
+ dummy_right_bl_0_0 dummy_right_br_0_0 gnd rbl_wl_0_0 wl_0_0 wl_0_1
+ wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7 wl_0_8 wl_0_9 wl_0_10
+ wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 gnd vdd gnd
+ sram_8b_16_1rw_tsmc65N_dummy_array_3
.ENDS sram_8b_16_1rw_tsmc65N_capped_replica_bitcell_array

* spice ptx M{0} {1} pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p

* spice ptx M{0} {1} nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

* spice ptx M{0} {1} nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

.SUBCKT sram_8b_16_1rw_tsmc65N_pnand2
+ A B Z vdd gnd
* INPUT : A 
* INPUT : B 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpnand2_pmos1 vdd A Z vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand2_pmos2 Z B vdd vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand2_nmos1 Z B net1 gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
Mpnand2_nmos2 net1 A gnd gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pnand2

* spice ptx M{0} {1} pch m=1 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p

* spice ptx M{0} {1} nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_0
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 2
Mpinv_pmos Z A vdd vdd pch m=1 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p
Mpinv_nmos Z A gnd gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_0

.SUBCKT sram_8b_16_1rw_tsmc65N_wordline_driver
+ A B Z vdd gnd
* INPUT : A 
* INPUT : B 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* cols: 8
Xwld_nand
+ A B zb_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pnand2
Xwl_driver
+ zb_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_0
.ENDS sram_8b_16_1rw_tsmc65N_wordline_driver

.SUBCKT sram_8b_16_1rw_tsmc65N_wordline_driver_array
+ in_0 in_1 in_2 in_3 in_4 in_5 in_6 in_7 in_8 in_9 in_10 in_11 in_12
+ in_13 in_14 in_15 wl_0 wl_1 wl_2 wl_3 wl_4 wl_5 wl_6 wl_7 wl_8 wl_9
+ wl_10 wl_11 wl_12 wl_13 wl_14 wl_15 en vdd gnd
* INPUT : in_0 
* INPUT : in_1 
* INPUT : in_2 
* INPUT : in_3 
* INPUT : in_4 
* INPUT : in_5 
* INPUT : in_6 
* INPUT : in_7 
* INPUT : in_8 
* INPUT : in_9 
* INPUT : in_10 
* INPUT : in_11 
* INPUT : in_12 
* INPUT : in_13 
* INPUT : in_14 
* INPUT : in_15 
* OUTPUT: wl_0 
* OUTPUT: wl_1 
* OUTPUT: wl_2 
* OUTPUT: wl_3 
* OUTPUT: wl_4 
* OUTPUT: wl_5 
* OUTPUT: wl_6 
* OUTPUT: wl_7 
* OUTPUT: wl_8 
* OUTPUT: wl_9 
* OUTPUT: wl_10 
* OUTPUT: wl_11 
* OUTPUT: wl_12 
* OUTPUT: wl_13 
* OUTPUT: wl_14 
* OUTPUT: wl_15 
* INPUT : en 
* POWER : vdd 
* GROUND: gnd 
* rows: 16 cols: 8
Xwl_driver_and0
+ in_0 en wl_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and1
+ in_1 en wl_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and2
+ in_2 en wl_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and3
+ in_3 en wl_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and4
+ in_4 en wl_4 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and5
+ in_5 en wl_5 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and6
+ in_6 en wl_6 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and7
+ in_7 en wl_7 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and8
+ in_8 en wl_8 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and9
+ in_9 en wl_9 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and10
+ in_10 en wl_10 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and11
+ in_11 en wl_11 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and12
+ in_12 en wl_12 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and13
+ in_13 en wl_13 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and14
+ in_14 en wl_14 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
Xwl_driver_and15
+ in_15 en wl_15 vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver
.ENDS sram_8b_16_1rw_tsmc65N_wordline_driver_array

* spice ptx M{0} {1} pch m=1 w=0.24u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p

* spice ptx M{0} {1} nch m=1 w=0.16u l=0.06u pd=0.44u ps=0.44u as=0.02p ad=0.02p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpinv_pmos Z A vdd vdd pch m=1 w=0.24u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpinv_nmos Z A gnd gnd nch m=1 w=0.16u l=0.06u pd=0.44u ps=0.44u as=0.02p ad=0.02p
.ENDS sram_8b_16_1rw_tsmc65N_pinv

.SUBCKT sram_8b_16_1rw_tsmc65N_and2_dec
+ A B Z vdd gnd
* INPUT : A 
* INPUT : B 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Xpand2_dec_nand
+ A B zb_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pnand2
Xpand2_dec_inv
+ zb_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv
.ENDS sram_8b_16_1rw_tsmc65N_and2_dec

.SUBCKT sram_8b_16_1rw_tsmc65N_hierarchical_predecode2x4
+ in_0 in_1 out_0 out_1 out_2 out_3 vdd gnd
* INPUT : in_0 
* INPUT : in_1 
* OUTPUT: out_0 
* OUTPUT: out_1 
* OUTPUT: out_2 
* OUTPUT: out_3 
* POWER : vdd 
* GROUND: gnd 
Xpre_inv_0
+ in_0 inbar_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv
Xpre_inv_1
+ in_1 inbar_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv
XXpre2x4_and_0
+ inbar_0 inbar_1 out_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XXpre2x4_and_1
+ in_0 inbar_1 out_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XXpre2x4_and_2
+ inbar_0 in_1 out_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XXpre2x4_and_3
+ in_0 in_1 out_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
.ENDS sram_8b_16_1rw_tsmc65N_hierarchical_predecode2x4

.SUBCKT sram_8b_16_1rw_tsmc65N_hierarchical_decoder
+ addr_0 addr_1 addr_2 addr_3 decode_0 decode_1 decode_2 decode_3
+ decode_4 decode_5 decode_6 decode_7 decode_8 decode_9 decode_10
+ decode_11 decode_12 decode_13 decode_14 decode_15 vdd gnd
* INPUT : addr_0 
* INPUT : addr_1 
* INPUT : addr_2 
* INPUT : addr_3 
* OUTPUT: decode_0 
* OUTPUT: decode_1 
* OUTPUT: decode_2 
* OUTPUT: decode_3 
* OUTPUT: decode_4 
* OUTPUT: decode_5 
* OUTPUT: decode_6 
* OUTPUT: decode_7 
* OUTPUT: decode_8 
* OUTPUT: decode_9 
* OUTPUT: decode_10 
* OUTPUT: decode_11 
* OUTPUT: decode_12 
* OUTPUT: decode_13 
* OUTPUT: decode_14 
* OUTPUT: decode_15 
* POWER : vdd 
* GROUND: gnd 
Xpre_0
+ addr_0 addr_1 out_0 out_1 out_2 out_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_hierarchical_predecode2x4
Xpre_1
+ addr_2 addr_3 out_4 out_5 out_6 out_7 vdd gnd
+ sram_8b_16_1rw_tsmc65N_hierarchical_predecode2x4
XDEC_AND_0
+ out_0 out_4 decode_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_4
+ out_0 out_5 decode_4 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_8
+ out_0 out_6 decode_8 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_12
+ out_0 out_7 decode_12 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_1
+ out_1 out_4 decode_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_5
+ out_1 out_5 decode_5 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_9
+ out_1 out_6 decode_9 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_13
+ out_1 out_7 decode_13 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_2
+ out_2 out_4 decode_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_6
+ out_2 out_5 decode_6 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_10
+ out_2 out_6 decode_10 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_14
+ out_2 out_7 decode_14 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_3
+ out_3 out_4 decode_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_7
+ out_3 out_5 decode_7 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_11
+ out_3 out_6 decode_11 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
XDEC_AND_15
+ out_3 out_7 decode_15 vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec
.ENDS sram_8b_16_1rw_tsmc65N_hierarchical_decoder

.SUBCKT sram_8b_16_1rw_tsmc65N_and2_dec_0
+ A B Z vdd gnd
* INPUT : A 
* INPUT : B 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 2
Xpand2_dec_nand
+ A B zb_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pnand2
Xpand2_dec_inv
+ zb_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_0
.ENDS sram_8b_16_1rw_tsmc65N_and2_dec_0

.SUBCKT sram_8b_16_1rw_tsmc65N_port_address
+ addr_0 addr_1 addr_2 addr_3 wl_en wl_0 wl_1 wl_2 wl_3 wl_4 wl_5 wl_6
+ wl_7 wl_8 wl_9 wl_10 wl_11 wl_12 wl_13 wl_14 wl_15 rbl_wl vdd gnd
* INPUT : addr_0 
* INPUT : addr_1 
* INPUT : addr_2 
* INPUT : addr_3 
* INPUT : wl_en 
* OUTPUT: wl_0 
* OUTPUT: wl_1 
* OUTPUT: wl_2 
* OUTPUT: wl_3 
* OUTPUT: wl_4 
* OUTPUT: wl_5 
* OUTPUT: wl_6 
* OUTPUT: wl_7 
* OUTPUT: wl_8 
* OUTPUT: wl_9 
* OUTPUT: wl_10 
* OUTPUT: wl_11 
* OUTPUT: wl_12 
* OUTPUT: wl_13 
* OUTPUT: wl_14 
* OUTPUT: wl_15 
* OUTPUT: rbl_wl 
* POWER : vdd 
* GROUND: gnd 
Xrow_decoder
+ addr_0 addr_1 addr_2 addr_3 dec_out_0 dec_out_1 dec_out_2 dec_out_3
+ dec_out_4 dec_out_5 dec_out_6 dec_out_7 dec_out_8 dec_out_9 dec_out_10
+ dec_out_11 dec_out_12 dec_out_13 dec_out_14 dec_out_15 vdd gnd
+ sram_8b_16_1rw_tsmc65N_hierarchical_decoder
Xwordline_driver
+ dec_out_0 dec_out_1 dec_out_2 dec_out_3 dec_out_4 dec_out_5 dec_out_6
+ dec_out_7 dec_out_8 dec_out_9 dec_out_10 dec_out_11 dec_out_12
+ dec_out_13 dec_out_14 dec_out_15 wl_0 wl_1 wl_2 wl_3 wl_4 wl_5 wl_6
+ wl_7 wl_8 wl_9 wl_10 wl_11 wl_12 wl_13 wl_14 wl_15 wl_en vdd gnd
+ sram_8b_16_1rw_tsmc65N_wordline_driver_array
Xrbl_driver
+ wl_en vdd rbl_wl vdd gnd
+ sram_8b_16_1rw_tsmc65N_and2_dec_0
.ENDS sram_8b_16_1rw_tsmc65N_port_address

.SUBCKT sram_8b_16_1rw_tsmc65N_bank
+ dout0_0 dout0_1 dout0_2 dout0_3 dout0_4 dout0_5 dout0_6 dout0_7
+ rbl_bl_0_0 din0_0 din0_1 din0_2 din0_3 din0_4 din0_5 din0_6 din0_7
+ addr0_0 addr0_1 addr0_2 addr0_3 s_en0 p_en_bar0 w_en0 wl_en0 vdd gnd
* OUTPUT: dout0_0 
* OUTPUT: dout0_1 
* OUTPUT: dout0_2 
* OUTPUT: dout0_3 
* OUTPUT: dout0_4 
* OUTPUT: dout0_5 
* OUTPUT: dout0_6 
* OUTPUT: dout0_7 
* OUTPUT: rbl_bl_0_0 
* INPUT : din0_0 
* INPUT : din0_1 
* INPUT : din0_2 
* INPUT : din0_3 
* INPUT : din0_4 
* INPUT : din0_5 
* INPUT : din0_6 
* INPUT : din0_7 
* INPUT : addr0_0 
* INPUT : addr0_1 
* INPUT : addr0_2 
* INPUT : addr0_3 
* INPUT : s_en0 
* INPUT : p_en_bar0 
* INPUT : w_en0 
* INPUT : wl_en0 
* POWER : vdd 
* GROUND: gnd 
Xbitcell_array
+ rbl_bl_0_0 rbl_br_0_0 bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3
+ br_0_3 bl_0_4 br_0_4 bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 rbl_wl0
+ wl_0_0 wl_0_1 wl_0_2 wl_0_3 wl_0_4 wl_0_5 wl_0_6 wl_0_7 wl_0_8 wl_0_9
+ wl_0_10 wl_0_11 wl_0_12 wl_0_13 wl_0_14 wl_0_15 vdd gnd
+ sram_8b_16_1rw_tsmc65N_capped_replica_bitcell_array
Xport_data0
+ rbl_bl_0_0 rbl_br_0_0 bl_0_0 br_0_0 bl_0_1 br_0_1 bl_0_2 br_0_2 bl_0_3
+ br_0_3 bl_0_4 br_0_4 bl_0_5 br_0_5 bl_0_6 br_0_6 bl_0_7 br_0_7 dout0_0
+ dout0_1 dout0_2 dout0_3 dout0_4 dout0_5 dout0_6 dout0_7 din0_0 din0_1
+ din0_2 din0_3 din0_4 din0_5 din0_6 din0_7 s_en0 p_en_bar0 w_en0 vdd
+ gnd
+ sram_8b_16_1rw_tsmc65N_port_data
Xport_address0
+ addr0_0 addr0_1 addr0_2 addr0_3 wl_en0 wl_0_0 wl_0_1 wl_0_2 wl_0_3
+ wl_0_4 wl_0_5 wl_0_6 wl_0_7 wl_0_8 wl_0_9 wl_0_10 wl_0_11 wl_0_12
+ wl_0_13 wl_0_14 wl_0_15 rbl_wl0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_port_address
.ENDS sram_8b_16_1rw_tsmc65N_bank

.subckt dff D Q clk vdd gnd
** N=17 EP=5 FDC=24
M0 gnd clk 4 gnd nch L=6e-08 W=1.95e-07 $X=230 $Y=370 $dt=0
M1 3 4 gnd gnd nch L=6e-08 W=1.95e-07 $X=470 $Y=480 $dt=0
M2 12 4 gnd gnd nch L=6e-08 W=3.7e-07 $X=950 $Y=265 $dt=0
M3 5 D 12 gnd nch L=6e-08 W=3.7e-07 $X=1150 $Y=265 $dt=0
M4 13 3 5 gnd nch L=6e-08 W=1.5e-07 $X=1410 $Y=465 $dt=0
M5 gnd 6 13 gnd nch L=6e-08 W=1.5e-07 $X=1615 $Y=465 $dt=0
M6 6 5 gnd gnd nch L=6e-08 W=3.9e-07 $X=1855 $Y=285 $dt=0
M7 2 3 6 gnd nch L=6e-08 W=1.9e-07 $X=2115 $Y=425 $dt=0
M8 14 4 2 gnd nch L=6e-08 W=1.5e-07 $X=2440 $Y=415 $dt=0
M9 gnd 1 14 gnd nch L=6e-08 W=1.5e-07 $X=2645 $Y=415 $dt=0
M10 1 2 gnd gnd nch L=6e-08 W=3.9e-07 $X=2975 $Y=285 $dt=0
M11 Q 1 gnd gnd nch L=6e-08 W=3.9e-07 $X=3490 $Y=285 $dt=0
M12 vdd clk 4 vdd pch L=6e-08 W=2.6e-07 $X=230 $Y=1160 $dt=1
M13 vdd 4 3 vdd pch L=6e-08 W=2.6e-07 $X=470 $Y=995 $dt=1
M14 15 3 vdd vdd pch L=6e-08 W=4.6e-07 $X=950 $Y=1055 $dt=1
M15 5 D 15 vdd pch L=6e-08 W=4.6e-07 $X=1150 $Y=1055 $dt=1
M16 16 4 5 vdd pch L=6e-08 W=1.5e-07 $X=1410 $Y=1185 $dt=1
M17 vdd 6 16 vdd pch L=6e-08 W=1.5e-07 $X=1640 $Y=1185 $dt=1
M18 6 5 vdd vdd pch L=6e-08 W=5.2e-07 $X=1915 $Y=995 $dt=1
M19 2 4 6 vdd pch L=6e-08 W=2.6e-07 $X=2220 $Y=1095 $dt=1
M20 17 3 2 vdd pch L=6e-08 W=1.5e-07 $X=2530 $Y=1095 $dt=1
M21 vdd 1 17 vdd pch L=6e-08 W=1.5e-07 $X=2730 $Y=1095 $dt=1
M22 1 2 vdd vdd pch L=6e-08 W=5.2e-07 $X=2985 $Y=995 $dt=1
M23 Q 1 vdd vdd pch L=6e-08 W=5.2e-07 $X=3490 $Y=995 $dt=1
.ends dff



.SUBCKT sram_8b_16_1rw_tsmc65N_data_dff
+ din_0 din_1 din_2 din_3 din_4 din_5 din_6 din_7 dout_0 dout_1 dout_2
+ dout_3 dout_4 dout_5 dout_6 dout_7 clk vdd gnd
* INPUT : din_0 
* INPUT : din_1 
* INPUT : din_2 
* INPUT : din_3 
* INPUT : din_4 
* INPUT : din_5 
* INPUT : din_6 
* INPUT : din_7 
* OUTPUT: dout_0 
* OUTPUT: dout_1 
* OUTPUT: dout_2 
* OUTPUT: dout_3 
* OUTPUT: dout_4 
* OUTPUT: dout_5 
* OUTPUT: dout_6 
* OUTPUT: dout_7 
* INPUT : clk 
* POWER : vdd 
* GROUND: gnd 
* rows: 1 cols: 8
Xdff_r0_c0
+ din_0 dout_0 clk vdd gnd
+ dff
Xdff_r0_c1
+ din_1 dout_1 clk vdd gnd
+ dff
Xdff_r0_c2
+ din_2 dout_2 clk vdd gnd
+ dff
Xdff_r0_c3
+ din_3 dout_3 clk vdd gnd
+ dff
Xdff_r0_c4
+ din_4 dout_4 clk vdd gnd
+ dff
Xdff_r0_c5
+ din_5 dout_5 clk vdd gnd
+ dff
Xdff_r0_c6
+ din_6 dout_6 clk vdd gnd
+ dff
Xdff_r0_c7
+ din_7 dout_7 clk vdd gnd
+ dff
.ENDS sram_8b_16_1rw_tsmc65N_data_dff

* spice ptx M{0} {1} pch m=4 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p

* spice ptx M{0} {1} nch m=4 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_7
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 8
Mpinv_pmos Z A vdd vdd pch m=4 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p
Mpinv_nmos Z A gnd gnd nch m=4 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_7

* spice ptx M{0} {1} pch m=2 w=0.36u l=0.06u pd=0.84u ps=0.84u as=0.05p ad=0.05p

* spice ptx M{0} {1} nch m=2 w=0.24u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_6
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 3
Mpinv_pmos Z A vdd vdd pch m=2 w=0.36u l=0.06u pd=0.84u ps=0.84u as=0.05p ad=0.05p
Mpinv_nmos Z A gnd gnd nch m=2 w=0.24u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_6

* spice ptx M{0} {1} pch m=12 w=0.505u l=0.06u pd=1.13u ps=1.13u as=0.08p ad=0.08p

* spice ptx M{0} {1} nch m=12 w=0.335u l=0.06u pd=0.79u ps=0.79u as=0.05p ad=0.05p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_8
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 25
Mpinv_pmos Z A vdd vdd pch m=12 w=0.505u l=0.06u pd=1.13u ps=1.13u as=0.08p ad=0.08p
Mpinv_nmos Z A gnd gnd nch m=12 w=0.335u l=0.06u pd=0.79u ps=0.79u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_8

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_5
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpinv_pmos Z A vdd vdd pch m=1 w=0.24u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpinv_nmos Z A gnd gnd nch m=1 w=0.16u l=0.06u pd=0.44u ps=0.44u as=0.02p ad=0.02p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_5

.SUBCKT sram_8b_16_1rw_tsmc65N_pdriver_0
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* sizes: [1, 3, 8, 25]
Xbuf_inv1
+ A Zb1_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_5
Xbuf_inv2
+ Zb1_int Zb2_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_6
Xbuf_inv3
+ Zb2_int Zb3_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_7
Xbuf_inv4
+ Zb3_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_8
.ENDS sram_8b_16_1rw_tsmc65N_pdriver_0

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_12
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpinv_pmos Z A vdd vdd pch m=1 w=0.24u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpinv_nmos Z A gnd gnd nch m=1 w=0.16u l=0.06u pd=0.44u ps=0.44u as=0.02p ad=0.02p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_12

.SUBCKT sram_8b_16_1rw_tsmc65N_delay_chain
+ in out vdd gnd
* INPUT : in 
* OUTPUT: out 
* POWER : vdd 
* GROUND: gnd 
* fanouts: [4, 4, 4, 4, 4, 4, 4, 4, 4]
Xdinv0
+ in dout_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_0_0
+ dout_1 n_0_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_0_1
+ dout_1 n_0_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_0_2
+ dout_1 n_0_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_0_3
+ dout_1 n_0_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv1
+ dout_1 dout_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_1_0
+ dout_2 n_1_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_1_1
+ dout_2 n_1_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_1_2
+ dout_2 n_1_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_1_3
+ dout_2 n_1_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv2
+ dout_2 dout_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_2_0
+ dout_3 n_2_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_2_1
+ dout_3 n_2_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_2_2
+ dout_3 n_2_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_2_3
+ dout_3 n_2_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv3
+ dout_3 dout_4 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_3_0
+ dout_4 n_3_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_3_1
+ dout_4 n_3_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_3_2
+ dout_4 n_3_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_3_3
+ dout_4 n_3_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv4
+ dout_4 dout_5 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_4_0
+ dout_5 n_4_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_4_1
+ dout_5 n_4_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_4_2
+ dout_5 n_4_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_4_3
+ dout_5 n_4_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv5
+ dout_5 dout_6 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_5_0
+ dout_6 n_5_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_5_1
+ dout_6 n_5_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_5_2
+ dout_6 n_5_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_5_3
+ dout_6 n_5_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv6
+ dout_6 dout_7 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_6_0
+ dout_7 n_6_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_6_1
+ dout_7 n_6_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_6_2
+ dout_7 n_6_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_6_3
+ dout_7 n_6_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv7
+ dout_7 dout_8 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_7_0
+ dout_8 n_7_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_7_1
+ dout_8 n_7_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_7_2
+ dout_8 n_7_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_7_3
+ dout_8 n_7_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdinv8
+ dout_8 out vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_8_0
+ out n_8_0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_8_1
+ out n_8_1 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_8_2
+ out n_8_2 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
Xdload_8_3
+ out n_8_3 vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_12
.ENDS sram_8b_16_1rw_tsmc65N_delay_chain

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_11
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpinv_pmos Z A vdd vdd pch m=1 w=0.24u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpinv_nmos Z A gnd gnd nch m=1 w=0.16u l=0.06u pd=0.44u ps=0.44u as=0.02p ad=0.02p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_11

* spice ptx M{0} {1} pch m=3 w=0.405u l=0.06u pd=0.93u ps=0.93u as=0.06p ad=0.06p

* spice ptx M{0} {1} nch m=3 w=0.265u l=0.06u pd=0.65u ps=0.65u as=0.04p ad=0.04p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_9
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 5
Mpinv_pmos Z A vdd vdd pch m=3 w=0.405u l=0.06u pd=0.93u ps=0.93u as=0.06p ad=0.06p
Mpinv_nmos Z A gnd gnd nch m=3 w=0.265u l=0.06u pd=0.65u ps=0.65u as=0.04p ad=0.04p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_9

.SUBCKT sram_8b_16_1rw_tsmc65N_pdriver_1
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* sizes: [1, 5]
Xbuf_inv1
+ A Zb1_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_5
Xbuf_inv2
+ Zb1_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_9
.ENDS sram_8b_16_1rw_tsmc65N_pdriver_1

.SUBCKT sram_8b_16_1rw_tsmc65N_pnand2_1
+ A B Z vdd gnd
* INPUT : A 
* INPUT : B 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpnand2_pmos1 vdd A Z vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand2_pmos2 Z B vdd vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand2_nmos1 Z B net1 gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
Mpnand2_nmos2 net1 A gnd gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pnand2_1

* spice ptx M{0} {1} nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

.SUBCKT sram_8b_16_1rw_tsmc65N_pnand3_0
+ A B C Z vdd gnd
* INPUT : A 
* INPUT : B 
* INPUT : C 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpnand3_pmos1 vdd A Z vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand3_pmos2 Z B vdd vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand3_pmos3 Z C vdd vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand3_nmos1 Z C net1 gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
Mpnand3_nmos2 net1 B net2 gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
Mpnand3_nmos3 net2 A gnd gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pnand3_0

* spice ptx M{0} {1} nch m=8 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

* spice ptx M{0} {1} pch m=8 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_10
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 16
Mpinv_pmos Z A vdd vdd pch m=8 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p
Mpinv_nmos Z A gnd gnd nch m=8 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_10

.SUBCKT sram_8b_16_1rw_tsmc65N_pdriver_2
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* sizes: [16]
Xbuf_inv1
+ A Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_10
.ENDS sram_8b_16_1rw_tsmc65N_pdriver_2

.SUBCKT sram_8b_16_1rw_tsmc65N_pand3
+ A B C Z vdd gnd
* INPUT : A 
* INPUT : B 
* INPUT : C 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 16
Xpand3_nand
+ A B C zb_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pnand3_0
Xpand3_inv
+ zb_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pdriver_2
.ENDS sram_8b_16_1rw_tsmc65N_pand3

.SUBCKT sram_8b_16_1rw_tsmc65N_pnand2_0
+ A B Z vdd gnd
* INPUT : A 
* INPUT : B 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 1
Mpnand2_pmos1 vdd A Z vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand2_pmos2 Z B vdd vdd pch m=1 w=0.2416u l=0.06u pd=0.60u ps=0.60u as=0.04p ad=0.04p
Mpnand2_nmos1 Z B net1 gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
Mpnand2_nmos2 net1 A gnd gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pnand2_0

* spice ptx M{0} {1} pch m=6 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p

* spice ptx M{0} {1} nch m=6 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_3
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 12
Mpinv_pmos Z A vdd vdd pch m=6 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p
Mpinv_nmos Z A gnd gnd nch m=6 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_3

.SUBCKT sram_8b_16_1rw_tsmc65N_pdriver
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* sizes: [12]
Xbuf_inv1
+ A Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_3
.ENDS sram_8b_16_1rw_tsmc65N_pdriver

.SUBCKT sram_8b_16_1rw_tsmc65N_pand2
+ A B Z vdd gnd
* INPUT : A 
* INPUT : B 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 12
Xpand2_nand
+ A B zb_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pnand2_0
Xpand2_inv
+ zb_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pdriver
.ENDS sram_8b_16_1rw_tsmc65N_pand2

.SUBCKT sram_8b_16_1rw_tsmc65N_pdriver_3
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* sizes: [8]
Xbuf_inv1
+ A Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_7
.ENDS sram_8b_16_1rw_tsmc65N_pdriver_3

.SUBCKT sram_8b_16_1rw_tsmc65N_pand3_0
+ A B C Z vdd gnd
* INPUT : A 
* INPUT : B 
* INPUT : C 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 8
Xpand3_nand
+ A B C zb_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pnand3_0
Xpand3_inv
+ zb_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pdriver_3
.ENDS sram_8b_16_1rw_tsmc65N_pand3_0

.SUBCKT sram_8b_16_1rw_tsmc65N_pdriver_4
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* sizes: [1, 3]
Xbuf_inv1
+ A Zb1_int vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_5
Xbuf_inv2
+ Zb1_int Z vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_6
.ENDS sram_8b_16_1rw_tsmc65N_pdriver_4

* spice ptx M{0} {1} pch m=2 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p

* spice ptx M{0} {1} nch m=2 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_2
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 4
Mpinv_pmos Z A vdd vdd pch m=2 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p
Mpinv_nmos Z A gnd gnd nch m=2 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_2

.SUBCKT sram_8b_16_1rw_tsmc65N_pinv_1
+ A Z vdd gnd
* INPUT : A 
* OUTPUT: Z 
* POWER : vdd 
* GROUND: gnd 
* size: 2
Mpinv_pmos Z A vdd vdd pch m=1 w=0.485u l=0.06u pd=1.09u ps=1.09u as=0.07p ad=0.07p
Mpinv_nmos Z A gnd gnd nch m=1 w=0.32u l=0.06u pd=0.76u ps=0.76u as=0.05p ad=0.05p
.ENDS sram_8b_16_1rw_tsmc65N_pinv_1

.SUBCKT sram_8b_16_1rw_tsmc65N_dff_buf_0
+ D Q Qb clk vdd gnd
* INPUT : D 
* OUTPUT: Q 
* OUTPUT: Qb 
* INPUT : clk 
* POWER : vdd 
* GROUND: gnd 
* inv1: 2 inv2: 4
Xdff_buf_dff
+ D qint clk vdd gnd
+ dff
Xdff_buf_inv1
+ qint Qb vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_1
Xdff_buf_inv2
+ Qb Q vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_2
.ENDS sram_8b_16_1rw_tsmc65N_dff_buf_0

.SUBCKT sram_8b_16_1rw_tsmc65N_dff_buf_array
+ din_0 din_1 dout_0 dout_bar_0 dout_1 dout_bar_1 clk vdd gnd
* INPUT : din_0 
* INPUT : din_1 
* OUTPUT: dout_0 
* OUTPUT: dout_bar_0 
* OUTPUT: dout_1 
* OUTPUT: dout_bar_1 
* INPUT : clk 
* POWER : vdd 
* GROUND: gnd 
* rows: 2 cols: 1
* inv1: 2 inv2: 4
Xdff_r0_c0
+ din_0 dout_0 dout_bar_0 clk vdd gnd
+ sram_8b_16_1rw_tsmc65N_dff_buf_0
Xdff_r1_c0
+ din_1 dout_1 dout_bar_1 clk vdd gnd
+ sram_8b_16_1rw_tsmc65N_dff_buf_0
.ENDS sram_8b_16_1rw_tsmc65N_dff_buf_array

.SUBCKT sram_8b_16_1rw_tsmc65N_control_logic_rw
+ csb web clk rbl_bl s_en w_en p_en_bar wl_en clk_buf vdd gnd
* INPUT : csb 
* INPUT : web 
* INPUT : clk 
* INPUT : rbl_bl 
* OUTPUT: s_en 
* OUTPUT: w_en 
* OUTPUT: p_en_bar 
* OUTPUT: wl_en 
* OUTPUT: clk_buf 
* POWER : vdd 
* GROUND: gnd 
* num_rows: 16
* words_per_row: 1
* word_size 8
Xctrl_dffs
+ csb web cs_bar cs we_bar we clk_buf vdd gnd
+ sram_8b_16_1rw_tsmc65N_dff_buf_array
Xclkbuf
+ clk clk_buf vdd gnd
+ sram_8b_16_1rw_tsmc65N_pdriver_0
Xinv_clk_bar
+ clk_buf clk_bar vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_11
Xand2_gated_clk_bar
+ clk_bar cs gated_clk_bar vdd gnd
+ sram_8b_16_1rw_tsmc65N_pand2
Xand2_gated_clk_buf
+ clk_buf cs gated_clk_buf vdd gnd
+ sram_8b_16_1rw_tsmc65N_pand2
Xbuf_wl_en
+ gated_clk_bar wl_en vdd gnd
+ sram_8b_16_1rw_tsmc65N_pdriver_1
Xrbl_bl_delay_inv
+ rbl_bl_delay rbl_bl_delay_bar vdd gnd
+ sram_8b_16_1rw_tsmc65N_pinv_11
Xw_en_and
+ we rbl_bl_delay_bar gated_clk_bar w_en vdd gnd
+ sram_8b_16_1rw_tsmc65N_pand3
Xbuf_s_en_and
+ rbl_bl_delay gated_clk_bar we_bar s_en vdd gnd
+ sram_8b_16_1rw_tsmc65N_pand3_0
Xdelay_chain
+ rbl_bl rbl_bl_delay vdd gnd
+ sram_8b_16_1rw_tsmc65N_delay_chain
Xnand_p_en_bar
+ gated_clk_buf rbl_bl_delay p_en_bar_unbuf vdd gnd
+ sram_8b_16_1rw_tsmc65N_pnand2_1
Xbuf_p_en_bar
+ p_en_bar_unbuf p_en_bar vdd gnd
+ sram_8b_16_1rw_tsmc65N_pdriver_4
.ENDS sram_8b_16_1rw_tsmc65N_control_logic_rw

.SUBCKT sram_8b_16_1rw_tsmc65N_row_addr_dff
+ din_0 din_1 din_2 din_3 dout_0 dout_1 dout_2 dout_3 clk vdd gnd
* INPUT : din_0 
* INPUT : din_1 
* INPUT : din_2 
* INPUT : din_3 
* OUTPUT: dout_0 
* OUTPUT: dout_1 
* OUTPUT: dout_2 
* OUTPUT: dout_3 
* INPUT : clk 
* POWER : vdd 
* GROUND: gnd 
* rows: 4 cols: 1
Xdff_r0_c0
+ din_0 dout_0 clk vdd gnd
+ dff
Xdff_r1_c0
+ din_1 dout_1 clk vdd gnd
+ dff
Xdff_r2_c0
+ din_2 dout_2 clk vdd gnd
+ dff
Xdff_r3_c0
+ din_3 dout_3 clk vdd gnd
+ dff
.ENDS sram_8b_16_1rw_tsmc65N_row_addr_dff

.SUBCKT sram_8b_16_1rw_tsmc65N
+ din0[0] din0[1] din0[2] din0[3] din0[4] din0[5] din0[6] din0[7]
+ addr0[0] addr0[1] addr0[2] addr0[3] csb0 web0 clk0 dout0[0] dout0[1]
+ dout0[2] dout0[3] dout0[4] dout0[5] dout0[6] dout0[7] vdd gnd
* INPUT : din0[0] 
* INPUT : din0[1] 
* INPUT : din0[2] 
* INPUT : din0[3] 
* INPUT : din0[4] 
* INPUT : din0[5] 
* INPUT : din0[6] 
* INPUT : din0[7] 
* INPUT : addr0[0] 
* INPUT : addr0[1] 
* INPUT : addr0[2] 
* INPUT : addr0[3] 
* INPUT : csb0 
* INPUT : web0 
* INPUT : clk0 
* OUTPUT: dout0[0] 
* OUTPUT: dout0[1] 
* OUTPUT: dout0[2] 
* OUTPUT: dout0[3] 
* OUTPUT: dout0[4] 
* OUTPUT: dout0[5] 
* OUTPUT: dout0[6] 
* OUTPUT: dout0[7] 
* POWER : vdd 
* GROUND: gnd 
Xbank0
+ dout0[0] dout0[1] dout0[2] dout0[3] dout0[4] dout0[5] dout0[6]
+ dout0[7] rbl_bl0 bank_din0_0 bank_din0_1 bank_din0_2 bank_din0_3
+ bank_din0_4 bank_din0_5 bank_din0_6 bank_din0_7 a0_0 a0_1 a0_2 a0_3
+ s_en0 p_en_bar0 w_en0 wl_en0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_bank
Xcontrol0
+ csb0 web0 clk0 rbl_bl0 s_en0 w_en0 p_en_bar0 wl_en0 clk_buf0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_control_logic_rw
Xrow_address0
+ addr0[0] addr0[1] addr0[2] addr0[3] a0_0 a0_1 a0_2 a0_3 clk_buf0 vdd
+ gnd
+ sram_8b_16_1rw_tsmc65N_row_addr_dff
Xdata_dff0
+ din0[0] din0[1] din0[2] din0[3] din0[4] din0[5] din0[6] din0[7]
+ bank_din0_0 bank_din0_1 bank_din0_2 bank_din0_3 bank_din0_4
+ bank_din0_5 bank_din0_6 bank_din0_7 clk_buf0 vdd gnd
+ sram_8b_16_1rw_tsmc65N_data_dff
.ENDS sram_8b_16_1rw_tsmc65N
