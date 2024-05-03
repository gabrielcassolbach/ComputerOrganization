library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor is
   port( 
      clk:                    in std_logic; 
      rst:                    in std_logic;
      wr_en:                  in std_logic;
      cte:                    in unsigned(15 downto 0);
      data_reg_input:         in unsigned(15 downto 0);
      mux_cte_regs_sel:       in std_logic;
      mux_cte_ula_sel:        in std_logic;      
      p_sel_op:               in unsigned(1 downto 0);   
      p_selin_reg:            in unsigned(2 downto 0);
      p_selout_reg:           in unsigned(2 downto 0);
      ula_out_debug:          out unsigned(15 downto 0)
   );
end entity;

architecture struct of processor is 

--component
component ula is 
port(    data1_in, data2_in : in unsigned (15 downto 0);      
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
         data_out       : out unsigned(15 downto 0));
end component;

-- component
component acumulator is
port( clk      : in std_logic;
      rst      : in std_logic;
      wr_en    : in std_logic;
      acumulator_in  : in unsigned(15 downto 0);
      acumulator_out : out unsigned(15 downto 0));
end component;

--component
component mux is 
port(    control_signal: in std_logic; 
         a, b: in unsigned (15 downto 0);
         c: out unsigned (15 downto 0));
end component;

--signals
signal ula_output:         unsigned (15 downto 0);
signal ula_carry:          std_logic;
signal ula_overflow:       std_logic;
signal regbank_out:        unsigned(15 downto 0);
signal mux_cte_regs_out:   unsigned(15 downto 0);
signal mux_cte_ula_out:    unsigned(15 downto 0);
signal acumulator_out:     unsigned(15 downto 0);

   begin
   -- Mux para selecionar entre constante e saida do banco de regs.
   p_mux_cte_regs: mux port map (
      a => cte,
      b => regbank_out,
      control_signal => mux_cte_regs_sel, 
      c => mux_cte_regs_out
   );

   -- Mux para selecionar entre constante e saida da ULA
   p_mux_cte_ula: mux port map (
      a => cte, 
      b => ula_output,
      control_signal => mux_cte_ula_sel, 
      c => mux_cte_ula_out
   );
   
   p_regbank: register_bank port map (
      clk => clk, 
      rst => rst, 
      wr_en => wr_en, 
      data_in => data_reg_input, 
      selin_reg => p_selin_reg,
      selout_reg => p_selout_reg, 
      data_out => regbank_out
   );
   
   -- Tem como entrada um mux que seleciona entre a constante e a saida da ULA
   p_acumulator: acumulator port map (
      clk => clk,
      rst => rst,
      wr_en => wr_en,
      acumulator_in => mux_cte_ula_out,
      acumulator_out => acumulator_out
   );

   -- Uma das entradas da ULA é o acumulador, a outra um mux que seleciona entre o bando de regs. e a constante
   p_ula: ula port map (
      data1_in => mux_cte_regs_out,
      data2_in => acumulator_out,  --Uma entrada da ULA sempre é o acumulador 
      sel_op => p_sel_op,
      data3_out => ula_output,
      carry => ula_carry, 
      overflow => ula_overflow
   );


   ula_out_debug <= ula_output;
   
   end struct;