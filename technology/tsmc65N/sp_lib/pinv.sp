
.subckt pinv A Z vdd gnd
** N=4 EP=4 FDC=2
M0 Z A gnd gnd nch L=6e-08 W=1.95e-07 $X=240 $Y=395 $dt=0
M1 Z A vdd vdd pch L=6e-08 W=2.6e-07 $X=240 $Y=1175 $dt=1
.ends pinv
