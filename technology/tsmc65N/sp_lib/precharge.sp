
.SUBCKT precharge bl br en_bar vdd
MM2 br en_bar bl vdd pch l=60n w=120.0n m=1
MM1 bl en_bar vdd vdd pch l=60n w=120.0n m=1
MM0 br en_bar vdd vdd pch l=60n w=120.0n m=1
.ENDS precharge

