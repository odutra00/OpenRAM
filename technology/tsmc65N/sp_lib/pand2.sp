
.subckt pand2 A B Z vdd gnd
** N=7 EP=5 FDC=6
M0 7 A 1 gnd nch L=6e-08 W=1.95e-07 $X=290 $Y=285 $dt=0
M1 gnd B 7 gnd nch L=6e-08 W=1.95e-07 $X=510 $Y=285 $dt=0
M2 Z 1 gnd gnd nch L=6e-08 W=1.95e-07 $X=870 $Y=285 $dt=0
M3 1 A vdd vdd pch L=6e-08 W=2.6e-07 $X=290 $Y=1130 $dt=1
M4 vdd B 1 vdd pch L=6e-08 W=2.6e-07 $X=560 $Y=1130 $dt=1
M5 Z 1 vdd vdd pch L=6e-08 W=2.6e-07 $X=870 $Y=1130 $dt=1
.ends pand2
