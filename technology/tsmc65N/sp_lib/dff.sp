
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


