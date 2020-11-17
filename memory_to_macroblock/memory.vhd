library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity memory is
   port(mem_addr     : in std_logic_vector(2 downto 0); 
        mem_clock    : in std_logic; 
        mem_data_out : out std_logic_vector(11 downto 0) 
       );
end memory;

architecture behavioral of memory is
-- define the new type for the 128x8 RAM 
type RAM_ARRAY is array (0 to 8) of std_logic_vector (11 downto 0); -- change (0 to 8 ) to change ram size 
-- initial values in the RAM
signal RAM: RAM_ARRAY :=(
   "111100000000",
   "000011110000",
   "000000001111",
   "111111110000",
   "000011111111",
   "111100001111",
   "111111111111",
   "101010101010",
   "110011001100"
   ); 
begin
   process(mem_clock)
   begin
      if(rising_edge(mem_clock)) then
         mem_data_out <= RAM(to_integer(unsigned(mem_addr)));
      end if;
   end process;
end behavioral;