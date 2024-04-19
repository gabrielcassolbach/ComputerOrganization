library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
   port( 
      clk:           in std_logic; 
      rst:           in std_logic;
      wr_en:         in std_logic;
      mux_sel:       in std_logic;
      p_sel_op:      in unsigned(1 downto 0);   
      p_selin_reg:    in unsigned(2 downto 0);
      p_selout_reg:   in unsigned(2 downto 0);
      mux_pin:        in unsigned(15 downto 0);
      ula_out_debug:       out unsigned(15 downto 0)
   );
end entity;

architecture struct of processor is 

--component
component ula is 
port (  data1_in, data2_in : in unsigned (15 downto 0);      
        sel_op             : in unsigned(1 downto 0);        
        data3_out          : out unsigned (15 downto 0);     
        carry              : out std_logic;
        overflow           : out std_logic);
end component;

--component
component register_bank is
port(    clk, rst, wr_en: in  std_logic; 
         data_in        : in  unsigned(15 downto 0);
         selin_reg      : in  unsigned(2 downto 0);
         selout_reg     : in  unsigned(2 downto 0);
         acc_out        : out unsigned(15 downto 0);
         data_out       : out unsigned(15 downto 0));
end component;

--component
component mux is 
port(   control_signal: in std_logic; 
        a, b: in unsigned (15 downto 0);
        c: out unsigned (15 downto 0));
end component;

--signals
signal ula_output:   unsigned (15 downto 0);
signal ula_carry:    std_logic;
signal ula_overflow: std_logic;
signal regbank_out_01: unsigned(15 downto 0);
signal regbank_out_02: unsigned(15 downto 0); -- accumulator.
signal mux_out:        unsigned(15 downto 0);

   begin 
   p_regbank: register_bank port map (clk => clk, rst => rst, wr_en => wr_en, data_in => ula_output, selin_reg => p_selin_reg,
                                      selout_reg => p_selout_reg, acc_out => regbank_out_01, data_out => regbank_out_02); 

   p_ula: ula port map (data1_in => regbank_out_01, data2_in => mux_out, sel_op => p_sel_op, data3_out => ula_output,
                        carry => ula_carry, overflow => ula_overflow);

   p_mux: mux port map (a => regbank_out_02, b => mux_pin ,control_signal => mux_sel, c => mux_out); 

   ula_out_debug <= ula_output;
   
   end struct;