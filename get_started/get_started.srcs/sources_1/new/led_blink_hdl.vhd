----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.10.2020 15:02:07
-- Design Name: 
-- Module Name: led_blink_hdl - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity led_blink_hdl is
    Port ( led : out STD_LOGIC;
           clk : in STD_LOGIC);
end led_blink_hdl;

architecture rtl of led_blink_hdl is
constant max_count : natural := 10000000; --clock is set as 100mhz, LED must blink at O.5hz
begin
    process(clk)
    variable count : natural range 0 to max_count;
    begin
    if rising_edge(clk) then
        if count < max_count/2 then
            count := count+1;
            led<='1'; 
        elsif count<max_count then 
            led<='0'; 
            count:=count+1;
        else 
            led<='1';
            count := 0; 
        end if;
    end if;
    end process; 
end architecture rtl;
