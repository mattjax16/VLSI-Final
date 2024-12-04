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

M1 vo vi gnd gnd n105 W=300n L=1
M2 vo vi vdd vdd p105 W=300n L=1

.subckt inverter vdd vi vo gnd
xm5 vo vi gnd gnd n105 W=0.3u L=0.1u nf=1 m=1
xm6 vo vi vdd vdd p105 W=0.6u L=0.1u nf=1 m=1
.ends inverter

xinv0 vdd vi vo gnd inverter


* transient analysis
vinput vi gnd pulse 0 vdd 5u 0.5u 0.5u 4.5u 10u

.tran 1p 30u
.measure tran outrise 
+trig v(vo) val='vdd*0.1' rise=2
+targ v(vo) val='vdd*0.9' rise=2

.measure tran outfall 
+trig v(vo) val='vdd*0.9' fall=2
+targ v(vo) val='vdd*0.1' fall=2

.measure tran tphl 
+trig v(vi) val='vdd*0.5' rise=2
+targ v(vo) val='vdd*0.5' fall=2

.measure tran tplh 
+trig v(vi) val='vdd*0.5' fall=2
+targ v(vo) val='vdd*0.5' rise=2


.end