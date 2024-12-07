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

**** get rid of x'sm for cmos

********************************************************************************
* Library          : mylibrary
* Cell             : 3XOR
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
******
.subckt _3xor !a !b !c a b c vout
m5 net40 a !b !b p105 w=0.6u l=0.1u nf=1 m=1
m4 net40 !a b b p105 w=0.6u l=0.1u nf=1 m=1
m3 vout !c net40 net40 p105 w=0.6u l=0.1u nf=1 m=1
m2 net12 a b b p105 w=0.6u l=0.1u nf=1 m=1
m1 vout c net12 net12 p105 w=0.6u l=0.1u nf=1 m=1
m0 net12 !a !b !b p105 w=0.6u l=0.1u nf=1 m=1
m10 !b a net60 !b n105 w=0.3u l=0.1u nf=1 m=1
m11 b !a net60 b n105 w=0.3u l=0.1u nf=1 m=1
m9 net60 !c vout net60 n105 w=0.3u l=0.1u nf=1 m=1
m8 b a net48 b n105 w=0.3u l=0.1u nf=1 m=1
m7 net48 c vout net48 n105 w=0.3u l=0.1u nf=1 m=1
m6 !b !a net48 !b n105 w=0.3u l=0.1u nf=1 m=1
.ends _3xor

********************************************************************************
* Library          : mylibrary
* Cell             : inverter
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
.subckt inverter vdd vin vout vss
m0 vout vin vdd vdd p105 w=0.6u l=0.1u nf=1 m=1
m1 vout vin vss vss n105 w=0.3u l=0.1u nf=1 m=1
.ends inverter

********************************************************************************
* Library          : mylibrary
* Cell             : 3XOR_INVS
* View             : schematic
* View Search List : hspice hspiceD cmos.sch cmos_sch schematic veriloga
* View Stop List   : hspice hspiceD veriloga
********************************************************************************
.subckt _3xor_invs ain bin cin vdd vout vss
xi0 !a !b !c a b c net48 _3xor
xi11 vdd net48 vout vss inverter
xi10 vdd c !c vss inverter
xi9 vdd cin c vss inverter
xi8 vdd b !b vss inverter
xi7 vdd bin b vss inverter
xi2 vdd a !a vss inverter
xi1 vdd ain a vss inverter
.ends _3xor_invs




xnandaddr vi_a vi_b vi_c vo_0  vdd gnd _3xor_invs

* transient analysis
vinput_1 vi_a gnd pulse 0 0 5u 0.5u 0.5u 4.5u 10u
vinput_2 vi_b gnd pulse 0 vdd 5u 0.5u 0.5u 4.5u 10u
vinput_3 vi_c gnd pulse 0 vdd 5u 0.5u 0.5u 4.5u 10u

.tran 1p 30u
.measure tran outrise 
+trig v(vo_0) val='vdd*0.1' rise=2
+targ v(vo_0) val='vdd*0.9' rise=2

.measure tran outfall 
+trig v(vo_0) val='vdd*0.9' fall=2
+targ v(vo_0) val='vdd*0.1' fall=2

.measure tran tphl 
+trig v(vo_0) val='vdd*0.5' rise=2
+targ v(vo_0) val='vdd*0.5' fall=2

.measure tran tplh 
+trig v(vo_0) val='vdd*0.5' fall=2
+targ v(vo_0) val='vdd*0.5' rise=2


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