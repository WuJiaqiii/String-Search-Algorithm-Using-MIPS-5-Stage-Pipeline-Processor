set_property -dict {PACKAGE_PIN W5 IOSTANDARD LVCMOS33} [get_ports {clk}]

set_property -dict {PACKAGE_PIN T18 IOSTANDARD LVCMOS33} [get_ports {reset}]

set_property -dict {PACKAGE_PIN U16 IOSTANDARD LVCMOS33} [get_ports {LEDs[0]}]
set_property -dict {PACKAGE_PIN E19 IOSTANDARD LVCMOS33} [get_ports {LEDs[1]}]
set_property -dict {PACKAGE_PIN U19 IOSTANDARD LVCMOS33} [get_ports {LEDs[2]}]
set_property -dict {PACKAGE_PIN V19 IOSTANDARD LVCMOS33} [get_ports {LEDs[3]}]
set_property -dict {PACKAGE_PIN W18 IOSTANDARD LVCMOS33} [get_ports {LEDs[4]}]
set_property -dict {PACKAGE_PIN U15 IOSTANDARD LVCMOS33} [get_ports {LEDs[5]}]
set_property -dict {PACKAGE_PIN U14 IOSTANDARD LVCMOS33} [get_ports {LEDs[6]}]
set_property -dict {PACKAGE_PIN V14 IOSTANDARD LVCMOS33} [get_ports {LEDs[7]}]

set_property -dict {PACKAGE_PIN W7 IOSTANDARD LVCMOS33} [get_ports {BCDs[0]}]
set_property -dict {PACKAGE_PIN W6 IOSTANDARD LVCMOS33} [get_ports {BCDs[1]}]
set_property -dict {PACKAGE_PIN U8 IOSTANDARD LVCMOS33} [get_ports {BCDs[2]}]
set_property -dict {PACKAGE_PIN V8 IOSTANDARD LVCMOS33} [get_ports {BCDs[3]}]
set_property -dict {PACKAGE_PIN U5 IOSTANDARD LVCMOS33} [get_ports {BCDs[4]}]
set_property -dict {PACKAGE_PIN V5 IOSTANDARD LVCMOS33} [get_ports {BCDs[5]}]
set_property -dict {PACKAGE_PIN U7 IOSTANDARD LVCMOS33} [get_ports {BCDs[6]}]
set_property -dict {PACKAGE_PIN V7 IOSTANDARD LVCMOS33} [get_ports {BCDs[7]}]

set_property -dict {PACKAGE_PIN U2  IOSTANDARD LVCMOS33} [get_ports {ano[0]}]
set_property -dict {PACKAGE_PIN U4  IOSTANDARD LVCMOS33} [get_ports {ano[1]}]
set_property -dict {PACKAGE_PIN V4  IOSTANDARD LVCMOS33} [get_ports {ano[2]}]
set_property -dict {PACKAGE_PIN W4  IOSTANDARD LVCMOS33} [get_ports {ano[3]}]

create_clock -period 20.000 -name CLK -waveform {0.000 10.000} [get_ports {clk}]

set_property PACKAGE_PIN B18 [get_ports Rx_Serial]
set_property PACKAGE_PIN A18 [get_ports Tx_Serial]

set_property IOSTANDARD LVCMOS33 [get_ports Rx_Serial]
set_property IOSTANDARD LVCMOS33 [get_ports Tx_Serial]