.lib '/usr/cots/synopsys/UniversityLibrary/SAED32_EDK/tech/hspice/saed32nm.lib' TT
.include '/usr/cots/synopsys/UniversityLibrary/SAED32_EDK/lib/stdcell_rvt/hspice/saed32nm_rvt.spf'

*post the results
.option post
.global vdd gnd

*define model
.model n105 nmos level=54
.model p105 pmos level=54

*source declaration
vvdd vdd 0 vdd *syntax:vname pos_node neg_node voltage_value
vgnd gnd 0 0v

*M1 vo vi gnd gnd n105 W=300n L=1
*M2 vo vi vdd vdd p105 W=300n L=1

*.subckt inverter vdd vi vo gnd
*xm5 vo vi gnd gnd n105 W=0.3u L=0.1u nf=1 m=1
*xm6 vo vi vdd vdd p105 W=0.6u L=0.1u nf=1 m=1
*.ends inverter

xinv0 vi vo inverter
