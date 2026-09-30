
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
