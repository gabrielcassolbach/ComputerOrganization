library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_bank is
   port( clk            : in  std_logic; 
         rst            : in  std_logic; 
         wr_en          : in  std_logic; 
         data_in        : in  unsigned(15 downto 0);
         selin_reg      : in  unsigned(2 downto 0);
         selout_reg     : in  unsigned(2 downto 0);
         acc_out        : out unsigned(15 downto 0);
         data_out       : out unsigned(15 downto 0)
   );
end entity;

architecture struct of register_bank is 
      
-- component
component reg16bits is
port( clk      : in std_logic;
      rst      : in std_logic;
      wr_en    : in std_logic;
      data_in  : in unsigned(15 downto 0);
      data_out : out unsigned(15 downto 0));
end component;

--signals 
signal wr_en0: std_logic;
signal wr_en1: std_logic;
signal wr_en2: std_logic;
signal wr_en3: std_logic;
signal wr_en4: std_logic;
signal wr_en5: std_logic;
signal wr_en6: std_logic;
signal wr_en7: std_logic;

signal saida_reg0: unsigned(15 downto 0);
signal saida_reg1: unsigned(15 downto 0); -- registrador responsável pelo acumulador.
signal saida_reg2: unsigned(15 downto 0);
signal saida_reg3: unsigned(15 downto 0);
signal saida_reg4: unsigned(15 downto 0);
signal saida_reg5: unsigned(15 downto 0);
signal saida_reg6: unsigned(15 downto 0);
signal saida_reg7: unsigned(15 downto 0);


      begin 
      reg0: reg16bits port map (clk => clk, rst => rst, wr_en => '0', data_in => "0000000000000000",   data_out => saida_reg0); 
      reg1: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en1 and wr_en, data_in => data_in, data_out => saida_reg1); 
      reg2: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en2 and wr_en, data_in => data_in, data_out => saida_reg2); 
      reg3: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en3 and wr_en, data_in => data_in, data_out => saida_reg3); 
      reg4: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en4 and wr_en, data_in => data_in, data_out => saida_reg4); 
      reg5: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en5 and wr_en, data_in => data_in, data_out => saida_reg5); 
      reg6: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en6 and wr_en, data_in => data_in, data_out => saida_reg6); 
      reg7: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en7 and wr_en, data_in => data_in, data_out => saida_reg7); 
      
      wr_en0 <= (not(selin_reg(2))) and (not(selin_reg(1))) and (not(selin_reg(0))); --000
      wr_en1 <= (not(selin_reg(2))) and (not(selin_reg(1))) and (   (selin_reg(0))); --001
      wr_en2 <= (not(selin_reg(2))) and (   (selin_reg(1))) and (not(selin_reg(0))); --010
      wr_en3 <= (not(selin_reg(2))) and (   (selin_reg(1))) and (   (selin_reg(0))); --011
      wr_en4 <= (   (selin_reg(2))) and (not(selin_reg(1))) and (not(selin_reg(0))); --100
      wr_en5 <= (   (selin_reg(2))) and (not(selin_reg(1))) and (   (selin_reg(0))); --101
      wr_en6 <= (   (selin_reg(2))) and (   (selin_reg(1))) and (not(selin_reg(0))); --110
      wr_en7 <= (   (selin_reg(2))) and (   (selin_reg(1))) and (   (selin_reg(0))); --111
      

      data_out <= saida_reg0 when selout_reg = "000" else 
                  saida_reg1 when selout_reg = "001" else 
                  saida_reg2 when selout_reg = "010" else 
                  saida_reg3 when selout_reg = "011" else 
                  saida_reg4 when selout_reg = "100" else 
                  saida_reg5 when selout_reg = "101" else 
                  saida_reg6 when selout_reg = "110" else 
                  saida_reg7;

      acc_out <= saida_reg1;

      end struct;


