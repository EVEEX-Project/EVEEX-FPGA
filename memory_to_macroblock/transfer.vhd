library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity transfer is
    port(cout   : out std_logic_vector (2 downto 0); -- Output of the counter
         enable : in  std_logic;                     -- Enable counting
         clk    : in  std_logic;                     -- Input clock
         reset  : in  std_logic                      -- Input reset
        );
end transfer;
  
architecture behavioral of transfer is
signal count :std_logic_vector (2 downto 0);
begin
    process (clk, reset)
    begin
    if (reset = '1') then
        count <= (others=>'0');
    elsif (rising_edge(clk)) then
        if (enable = '1') then
            count <= count + 1;
        end if;
    end if;
end process;
cout <= count;
end behavioral;