
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

