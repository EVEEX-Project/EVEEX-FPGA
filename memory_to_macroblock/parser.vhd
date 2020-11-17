library ieee;
use ieee.std_logic_1164.all;

entity parser is
   port (clk           : in  std_logic;
         current_pixel : in  std_logic_vector (11 downto 0);
         line_out      : out std_logic_vector (35 downto 0)
        );
end parser;

architecture behavioral of parser is
signal line_latch      : std_logic_vector(35 downto 0) := (others => '0');  
begin
   process(clk)
   begin
      if rising_edge(clk) then
            line_out   <= line_latch(35 downto 24) & line_latch(23 downto 12) & line_latch(11 downto 0); 
            line_latch <= line_latch(23 downto  0) & current_pixel;
      end if;
   end process;
end behavioral;