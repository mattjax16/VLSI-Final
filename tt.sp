*library file
.lib '/usr/cots/synopsys/UniversityLibrary/SAED32_EDK/tech/hspice/saed32nm.lib' TT
.include '/usr/cots/synopsys/UniversityLibrary/SAED32_EDK/lib/stdcell_rvt/hspice/saed32nm_rvt.spf'

*post the results
.option post
.global vdd gnd vi_a vi_b vi_c

*define model
.model n105 nmos level=54
.model p105 pmos level=54

*source declaration
vvdd vdd 0 vdd   *syntax:vname pos_node neg_node voltage_value
vgnd gnd 0 0v

*A Input source decleration

** A
* vvi_a vi_a 0 1.05v
vvi_a vi_a 0 0v

** B
* vvi_b vi_b 0 1.05v
vvi_b vi_b 0 0v

** C
* vvi_c vi_c 0 1.05v
vvi_c vi_c 0 0v



*set source voltage
.param vdd = 1.05 *Define the voltage value of Vdd as 1.05V.



********************************************************************************
* Library          : mylibrary
* Cell             : inverter
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
.subckt inverter vdd vin vout vss
xm0 vout vin vdd vdd p105 w=0.6u l=0.1u nf=1 m=1
xm1 vout vin vss vss n105 w=0.3u l=0.1u nf=1 m=1
.ends inverter

********************************************************************************
* Library          : mylibrary
* Cell             : N1_F
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
.subckt n1_f a b c vdd vout vss
xm4 vout !c net5 net5 n105 w=0.3u l=0.1u nf=1 m=1
xm3 vout !b net5 net5 n105 w=0.3u l=0.1u nf=1 m=1
xm2 net9 !c vss vss n105 w=0.3u l=0.1u nf=1 m=1
xm1 net5 !b net9 net9 n105 w=0.3u l=0.1u nf=1 m=1
xm0 net5 !a vss vss n105 w=0.3u l=0.1u nf=1 m=1
xm9 net39 !b vdd vdd p105 w=0.6u l=0.1u nf=1 m=1
xm8 vout !c net39 net39 p105 w=0.6u l=0.1u nf=1 m=1
xm7 vout !c net29 net29 p105 w=0.6u l=0.1u nf=1 m=1
xm6 vout !b net29 net29 p105 w=0.6u l=0.1u nf=1 m=1
xm5 net29 !a vdd vdd p105 w=0.6u l=0.1u nf=1 m=1
xi12 net50 c !c net51 inverter
xi11 net46 b !b net47 inverter
xi10 net42 a !a net43 inverter
.ends n1_f






* .param vi_a = 1.05
* .param vi_b = 1.05
* .param vi_c = 0             

* Just Hook up vdd and gnd for which one we want as high
*         a  b   c  vdd vout vss
xnandaddr vi_a vi_b vi_c vdd vo gnd n1_f
* xnandaddr vdd vdd vdd vo_0  vdd gnd n1_b_inv



* * transient analysis
* vinput_1 vi_a gnd pulse 0 vdd 5u 0.5u 0.5u 4.5u 10u
* vinput_2 vi_b gnd pulse 0 vdd 5u 0.5u 0.5u 4.5u 10u
* vinput_3 vi_c gnd pulse 0 0 5u 0.5u 0.5u 4.5u 10u

.tran 1p 65u
* .measure tran outrise 
* +trig v(vo) val='vdd*0.1' rise=2
* +targ v(vo) val='vdd*0.9' rise=2

* .measure tran outfall 
* +trig v(vo) val='vdd*0.9' fall=2
* +targ v(vo) val='vdd*0.1' fall=2

* .measure tran tphl 
* +trig v(vo) val='vdd*0.5' rise=2
* +targ v(vo) val='vdd*0.5' fall=2

* .measure tran tplh 
* +trig v(vo) val='vdd*0.5' fall=2
* +targ v(vo) val='vdd*0.5' rise=2


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