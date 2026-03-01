##---------------------------------------------------------------------------------
## License: CC0-1.0 https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt
## Repository: https://github.com/LarsRockstroh/SwGuides/
## Filename: WaveGen4Bit_top.xdc
## Language: XDC
## Description:
##  . Pin configuration Spartan7 development board
## History:
## 01.00, 2026-02-28
##   Initial
##---------------------------------------------------------------------------------



## Clock signal
set_property -dict { PACKAGE_PIN H11    IOSTANDARD LVCMOS33 } [get_ports { i_Clk_48MHz }];
create_clock -add -name sys_clk_pin -period 20.833 -waveform {0.000 10.416} [get_ports { i_Clk_48MHz }];

#PowerOnReset
set_property -dict { PACKAGE_PIN M10    IOSTANDARD LVCMOS33 } [get_ports { i_nPOR_FPGA }]; 


set_property -dict { PACKAGE_PIN P12    IOSTANDARD LVCMOS33 } [get_ports { o_Wave[0] }]; 
set_property -dict { PACKAGE_PIN P11    IOSTANDARD LVCMOS33 } [get_ports { o_Wave[1] }]; 
set_property -dict { PACKAGE_PIN N10    IOSTANDARD LVCMOS33 } [get_ports { o_Wave[2] }]; 
set_property -dict { PACKAGE_PIN P10    IOSTANDARD LVCMOS33 } [get_ports { o_Wave[3] }];  

set_property -dict { PACKAGE_PIN B14    IOSTANDARD LVCMOS33 } [get_ports { i_Limit[0] }]; 
set_property -dict { PACKAGE_PIN B13    IOSTANDARD LVCMOS33 } [get_ports { i_Limit[1] }]; 
set_property -dict { PACKAGE_PIN A13    IOSTANDARD LVCMOS33 } [get_ports { i_Limit[2] }]; 
set_property -dict { PACKAGE_PIN A12    IOSTANDARD LVCMOS33 } [get_ports { i_Limit[3] }]; 

set_property -dict { PACKAGE_PIN L13    IOSTANDARD LVCMOS33 } [get_ports { i_Limit_Valid }]; 
set_property -dict { PACKAGE_PIN J11    IOSTANDARD LVCMOS33 } [get_ports { o_Limit_Ready }]; 



#General configuration
set_property BITSTREAM.CONFIG.UNUSEDPIN Pulldown [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 40 [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property BITSTREAM.GENERAL.CRC ENABLE [current_design]

# DRC of configuration pins
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
