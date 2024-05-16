library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
   port( 
      clk      : in std_logic;
      wr_en    : in std_logic;
      rst      : in std_logic;
      increment: in unsigned (6 downto 0);
      data_out : out unsigned (6 downto 0)
   );
end entity;

architecture struct of program_counter is 
    
      --component
      component reg7bits is
      port (  
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0));
      end component;

      --component (adder)
      component adder is
      port(
            increment: in unsigned (6 downto 0);
            data_in  : in unsigned  (6 downto 0);
            data_out : out unsigned (6 downto 0));
      end component;

      --signals
      signal pc_out : unsigned (6 downto 0);
      signal incrementer_out: unsigned (6 downto 0) := "1111111";

begin
      pc: reg7bits port map (
            clk => clk, 
            rst => rst, 
            wr_en => wr_en, 
            data_in => incrementer_out, 
            data_out => pc_out);

      incrementer: adder port map (
            increment => increment,
            data_in => pc_out, 
            data_out => incrementer_out);

      data_out <= pc_out;

end struct;