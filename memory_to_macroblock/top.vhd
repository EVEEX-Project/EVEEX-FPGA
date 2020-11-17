library ieee;
use ieee.STD_LOGIC_1164.all;
USE ieee.numeric_std.all;

entity top is
     port(clock    : in  std_logic;
          enable   : in  std_logic;                     
          reset    : in  std_logic;                   
          line_out : out std_logic_vector(35 downto 0) 
         );
end top;

architecture behavioral of top is
signal addr_s : std_logic_vector(2 downto 0);
signal data_s : std_logic_vector(11 downto 0);
component transfer is
     port(cout   : out std_logic_vector (2 downto 0); 
          enable : in  std_logic;                     
          clk    : in  std_logic;                     
          reset  : in  std_logic                      
         );
end component;

component memory is
     port(mem_addr     : in std_logic_vector(2 downto 0); 
          mem_clock    : in std_logic; 
          mem_data_out : out std_logic_vector(11 downto 0) 
    );
end component;

component parser is
     port (clk           : in  std_logic;
           current_pixel : in  std_logic_vector (11 downto 0);
           line_out      : out std_logic_vector (35 downto 0)
    );
end component;

begin
uut0:memory port map(mem_addr     => addr_s,
                     mem_clock    => clock,
                     mem_data_out => data_s);
uut1:transfer port map(cout => addr_s,
                     enable => enable,
                     clk    => clock,
                     reset  => reset);
uut2:parser port map(clk           => clock,
                     current_pixel => data_s,
                     line_out      => line_out);
end behavioral;