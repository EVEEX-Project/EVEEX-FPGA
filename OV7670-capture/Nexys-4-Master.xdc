## This file is a general .xdc for the Nexys4 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
##Bank = 35, Pin name = IO_L12P_T1_MRCC_35,					Sch name = CLK100MHZ
set_property PACKAGE_PIN E3 [get_ports {clk100} ]							
	#set_property IOSTANDARD LVCMOS33 [get_ports clk]
	#create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]
 

 


## LEDs

set_property PACKAGE_PIN T8 [get_ports {LED[0]}]					
	
set_property PACKAGE_PIN V9 [get_ports {LED[1]}]					
	
set_property PACKAGE_PIN R8 [get_ports {LED[2]}]					
	
set_property PACKAGE_PIN T6 [get_ports {LED[3]}]					
	
set_property PACKAGE_PIN T5 [get_ports {LED[4]}]					
	
set_property PACKAGE_PIN T4 [get_ports {LED[5]}]					
	
set_property PACKAGE_PIN U7 [get_ports {LED[6]}]					
	
set_property PACKAGE_PIN U6 [get_ports {LED[7]}]					




##Buttons

set_property PACKAGE_PIN E16 [get_ports btn]						
	
 


##Pmod Header JA

set_property PACKAGE_PIN B13 [get_ports {OV7670_PWDN}]					
	
set_property PACKAGE_PIN F14 [get_ports {OV7670_RESET}]					
	
set_property PACKAGE_PIN D17 [get_ports {OV7670_D[0]}]					
	
set_property PACKAGE_PIN E17 [get_ports {OV7670_D[1]}]					
	
set_property PACKAGE_PIN G13 [get_ports {OV7670_D[2]}]					
	
set_property PACKAGE_PIN C17 [get_ports {OV7670_D[3]}]					
	
set_property PACKAGE_PIN D18 [get_ports {OV7670_D[4]}]					
	
set_property PACKAGE_PIN E18 [get_ports {OV7670_D[5]}]					
	



##Pmod Header JB

set_property PACKAGE_PIN G14 [get_ports {OV7670_D[6]}]					
	
set_property PACKAGE_PIN P15 [get_ports {OV7670_D[7]}]					
	
set_property PACKAGE_PIN V11 [get_ports {OV7670_XCLK}]					
	
set_property PACKAGE_PIN V15 [get_ports {OV7670_PCLK}]					
	
set_property PACKAGE_PIN K16 [get_ports {OV7670_HREF}]					
	
set_property PACKAGE_PIN R16 [get_ports {OV7670_VSYNC}]					
	
set_property PACKAGE_PIN T9 [get_ports {OV7670_SIOD}]					
	
set_property PACKAGE_PIN U11 [get_ports {OV7670_SIOC}]					
	
 


##VGA Connector

set_property PACKAGE_PIN A3 [get_ports {vga_red[0]}]				
	
set_property PACKAGE_PIN B4 [get_ports {vga_red[1]}]				
	
set_property PACKAGE_PIN C5 [get_ports {vga_red[2]}]				
	
set_property PACKAGE_PIN A4 [get_ports {vga_red[3]}]				
	
set_property PACKAGE_PIN B7 [get_ports {vga_blue[0]}]				
	
set_property PACKAGE_PIN C7 [get_ports {vga_blue[1]}]				
	
set_property PACKAGE_PIN D7 [get_ports {vga_blue[2]}]				
	
set_property PACKAGE_PIN D8 [get_ports {vga_blue[3]}]				
	
set_property PACKAGE_PIN C6 [get_ports {vga_green[0]}]				
	
set_property PACKAGE_PIN A5 [get_ports {vga_green[1]}]				
	
set_property PACKAGE_PIN B6 [get_ports {vga_green[2]}]				
	
set_property PACKAGE_PIN A6 [get_ports {vga_green[3]}]				
	
set_property PACKAGE_PIN B11 [get_ports {vga_hsync}]						
	
set_property PACKAGE_PIN B12 [get_ports {vga_vsync}]						
	
# Voltage levels
set_property IOSTANDARD LVTTL [get_ports btn]
set_property IOSTANDARD LVTTL [get_ports {LED[*]}]

set_property IOSTANDARD LVTTL [get_ports OV7670_PCLK]
set_property IOSTANDARD LVTTL [get_ports OV7670_SIOC]
set_property IOSTANDARD LVTTL [get_ports OV7670_VSYNC]
set_property IOSTANDARD LVTTL [get_ports OV7670_RESET]
set_property IOSTANDARD LVTTL [get_ports OV7670_PWDN]
set_property IOSTANDARD LVTTL [get_ports OV7670_HREF]
set_property IOSTANDARD LVTTL [get_ports OV7670_XCLK]
set_property IOSTANDARD LVTTL [get_ports OV7670_SIOD]
set_property IOSTANDARD LVTTL [get_ports {OV7670_D[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_blue[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_green[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {vga_red[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports vga_hsync]
set_property IOSTANDARD LVCMOS33 [get_ports vga_vsync]
set_property IOSTANDARD LVCMOS33 [get_ports clk100]

# Magic
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets OV7670_PCLK_IBUF]