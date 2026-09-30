
.SUBCKT dummy_cell_1rw bl br wl vdd gnd
MMM3 bl wl Q gnd nch l=60n w=135.00n m=1
MMM2 br wl Q_bar gnd nch l=60n w=135.00n m=1
MMM0 Q_bar Q gnd gnd nch l=60n w=205.00n m=1
MMM1 Q Q_bar gnd gnd nch l=60n w=205.00n m=1
MMM4 Q_bar Q vdd vdd pch l=60n w=120.0n m=1
MMM5 Q Q_bar vdd vdd pch l=60n w=120.0n m=1
.ENDS dummy_cell_1rw

