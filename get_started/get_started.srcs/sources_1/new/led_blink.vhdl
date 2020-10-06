library IEEE;
use IEEE.std_logic_1164.all;

entity led_blink
port(clk : in std_logic;
     led : out std_logic
    );
architecture rtl of led_blink is
constant max_count : natural := 100000000; -- Ref clock at 100MHz, LED should blink at 0.5MHz
    begin
        process(clk)
        variable count : natural range 0 to max_count;
        begin
        if rising_edge(clk) then
            if count < max_count/2 then
                count := count + 1;
                led <= '1';
            elsif count < max_count then
                led <= '0';
                count := count + 1;
            else
                led <= '1';
                count := 0;
            end if;
        end if;
        end process;
end architecture rtl;
