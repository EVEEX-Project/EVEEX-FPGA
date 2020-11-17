library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end entity;

architecture bhv of top_tb is

  constant HALF_PERIOD : time := 5 ns;

  signal clk     : std_logic := '0';
  signal running : boolean   := true;

  procedure wait_cycles(n : natural) is
   begin
     for i in 1 to n loop
       wait until rising_edge(clk);
     end loop;
   end procedure;

  signal enable   : std_logic;
  signal reset    : std_logic;
  signal line_out : std_logic_vector(35 downto 0);

begin
  -------------------------------------------------------------------
  -- clock
  -------------------------------------------------------------------
  clk <= not(clk) after HALF_PERIOD when running else clk;

  --------------------------------------------------------------------
  -- Design Under Test
  --------------------------------------------------------------------
  dut : entity work.top(behavioral)
        
        port map (
          clock     => clk  ,
          enable    => enable,
          reset     => reset ,
          line_out  => line_out 
        );

  --------------------------------------------------------------------
  -- sequential stimuli
  --------------------------------------------------------------------
  stim : process
   begin
     report "applying stimuli...";
     enable <= '0'; reset  <= '0'; wait_cycles(2);
     enable <= '0'; reset  <= '1'; wait_cycles(2);
     enable <= '1'; reset  <= '0'; wait_cycles(10);
     report "end of simulation";
     running <= false;
     wait;
   end process;

end bhv;
