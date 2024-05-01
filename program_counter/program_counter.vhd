library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
   port( 
      clk      : in std_logic;
      wr_en    : in std_logic;
      rst      : in std_logic;
      data_out : out unsigned (6 downto 0)
   );
end entity;

architecture struct of program_counter is 
    
      --component
      component reg7bits is
      port (  clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0));
      end component;

      --component (adder)
      component adder is
      port(
            data_in  : in unsigned  (6 downto 0);
            data_out : out unsigned (6 downto 0));
      end component;

      --signals
      signal pc_out : unsigned (6 downto 0);
      signal add_oneout: unsigned (6 downto 0);

begin
      pc: reg7bits port map (
            clk => clk, 
            rst => rst, 
            wr_en => wr_en, 
            data_in => add_oneout, 
            data_out => pc_out);

      addone: adder port map (
            data_in => pc_out, 
            data_out => add_oneout);

      data_out <= pc_out;

end struct;