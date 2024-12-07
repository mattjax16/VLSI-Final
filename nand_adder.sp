*library file
.lib '/usr/cots/synopsys/UniversityLibrary/SAED32_EDK/tech/hspice/saed32nm.lib' TT
.include '/usr/cots/synopsys/UniversityLibrary/SAED32_EDK/lib/stdcell_rvt/hspice/saed32nm_rvt.spf'

*post the results
.option post
.global vdd gnd

*define model
.model n105 nmos level=54
.model p105 pmos level=54

*source declaration
vvdd vdd 0 vdd   *syntax:vname pos_node neg_node voltage_value
vgnd gnd 0 0v


*set source voltage
.param vdd = 1.05 *Define the voltage value of Vdd as 1.05V.
.param l = 100n

********************************************************************************
* Library          : mylibrary
* Cell             : NAND2
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
.subckt nand2 a b vdd vout vss
xm1 vout b vdd vdd p105 w=0.6u l=0.1u nf=1 m=1
xm0 vout a vdd vdd p105 w=0.6u l=0.1u nf=1 m=1
xm3 vout a net30 vss n105 w=0.3u l=0.1u nf=1 m=1
xm2 net30 b vss vss n105 w=0.3u l=0.1u nf=1 m=1
.ends nand2

********************************************************************************
* Library          : mylibrary
* Cell             : NAND_ADDR_3
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
.subckt nand_addr_3 a b c n0 n1 vdd vss
xi10 ![[anorb]*c] ![ab] vdd n1 vss nand2
xi0 a b vdd ![ab] vss nand2
xi9 a ![ab] vdd net71 vss nand2
xi8 ![ab] b vdd net72 vss nand2
xi6 net71 net72 vdd axorb vss nand2
xi4 axorb c vdd ![[anorb]*c] vss nand2
xi1 axorb ![[anorb]*c] vdd net29 vss nand2
xi2 ![[anorb]*c] c vdd net30 vss nand2
xi7 net29 net30 vdd n0 vss nand2
.ends nand_addr_3


xnandaddr vi_a vi_b vi_c vo vo_1 vdd gnd nand_addr_3

* transient analysis
vinput_1 vi_a gnd pulse 0 vdd 5u 0.5u 0.5u 4.5u 10u
vinput_2 vi_b gnd pulse 0 vdd 5u 0.5u 0.5u 4.5u 10u
vinput_3 vi_c gnd pulse 0 0 5u 0.5u 0.5u 4.5u 10u

.tran 1p 30u
.measure tran outrise 
+trig v(vo) val='vdd*0.1' rise=2
+targ v(vo) val='vdd*0.9' rise=2

.measure tran outfall 
+trig v(vo) val='vdd*0.9' fall=2
+targ v(vo) val='vdd*0.1' fall=2

.measure tran tphl 
+trig v(vo) val='vdd*0.5' rise=2
+targ v(vo) val='vdd*0.5' fall=2

.measure tran tplh 
+trig v(vo) val='vdd*0.5' fall=2
+targ v(vo) val='vdd*0.5' rise=2


* .measure tran outrise 
* +trig v(vo_1) val='vdd*0.1' rise=2
* +targ v(vo_1) val='vdd*0.9' rise=2

* .measure tran outfall 
* +trig v(vo_1) val='vdd*0.9' fall=2
* +targ v(vo_1) val='vdd*0.1' fall=2

* .measure tran tphl 
* +trig v(vo_1) val='vdd*0.5' rise=2
* +targ v(vo_1) val='vdd*0.5' fall=2

* .measure tran tplh 
* +trig v(vo_1) val='vdd*0.5' fall=2
* +targ v(vo_1) val='vdd*0.5' rise=2


.end