library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
   port( clk      : in std_logic;
         wr_en    : in std_logic;
         data_in  : in unsigned  (15 downto 0);
         data_out : out unsigned (15 downto 0)
   );
end entity;

architecture struct of program_counter is 
    
--signals
signal pc_out : unsigned (15 downto 0);
signal add_oneout: unsigned (15 downto 0);

--component
component reg16bits is
port (  clk      : in std_logic;
        rst      : in std_logic;
        wr_en    : in std_logic;
        data_in  : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0));
end component;

--component (adder)
component adder is
port( clk      : in std_logic;
      data_in  : in unsigned  (15 downto 0);
      data_out : out unsigned (15 downto 0));
end component;

    begin
    addone: adder port map (clk => clk, data_in => pc_out, data_out => add_oneout);
    pc: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en, data_in => add_oneout, data_out => pc_out); 
    end struct;