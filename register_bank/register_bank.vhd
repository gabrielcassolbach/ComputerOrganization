library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_bank is
   port( clk, rst, wr_en: in  std_logic; 
         data_in        : in  unsigned(15 downto 0);
         selin_reg      : in  unsigned(2 downto 0);
         selout_reg     : in  unsigned(2 downto 0);
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

signal saida_r0: unsigned(15 downto 0);
signal saida_r1: unsigned(15 downto 0);
signal saida_r2: unsigned(15 downto 0);
signal saida_r3: unsigned(15 downto 0);
signal saida_r4: unsigned(15 downto 0);
signal saida_r5: unsigned(15 downto 0);
signal saida_r6: unsigned(15 downto 0);
signal saida_r7: unsigned(15 downto 0);

      begin 
      r0: reg16bits port map (clk => clk, rst => rst, wr_en => '0', data_in => "0000000000000000",   data_out => saida_r0); --registrador com constante zero
      r1: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en1 and wr_en, data_in => data_in, data_out => saida_r1); 
      r2: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en2 and wr_en, data_in => data_in, data_out => saida_r2); 
      r3: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en3 and wr_en, data_in => data_in, data_out => saida_r3); 
      r4: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en4 and wr_en, data_in => data_in, data_out => saida_r4); 
      r5: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en5 and wr_en, data_in => data_in, data_out => saida_r5); 
      r6: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en6 and wr_en, data_in => data_in, data_out => saida_r6); 
      r7: reg16bits port map (clk => clk, rst => rst, wr_en => wr_en7 and wr_en, data_in => data_in, data_out => saida_r7); 
      
      wr_en0 <= (not(selin_reg(2))) and (not(selin_reg(1))) and (not(selin_reg(0))); --000
      wr_en1 <= (not(selin_reg(2))) and (not(selin_reg(1))) and (   (selin_reg(0))); --001
      wr_en2 <= (not(selin_reg(2))) and (   (selin_reg(1))) and (not(selin_reg(0))); --010
      wr_en3 <= (not(selin_reg(2))) and (   (selin_reg(1))) and (   (selin_reg(0))); --011
      wr_en4 <= (   (selin_reg(2))) and (not(selin_reg(1))) and (not(selin_reg(0))); --100
      wr_en5 <= (   (selin_reg(2))) and (not(selin_reg(1))) and (   (selin_reg(0))); --101
      wr_en6 <= (   (selin_reg(2))) and (   (selin_reg(1))) and (not(selin_reg(0))); --110
      wr_en7 <= (   (selin_reg(2))) and (   (selin_reg(1))) and (   (selin_reg(0))); --111
      

      data_out <= saida_r0 when selout_reg = "000" else 
                  saida_r1 when selout_reg = "001" else 
                  saida_r2 when selout_reg = "010" else 
                  saida_r3 when selout_reg = "011" else 
                  saida_r4 when selout_reg = "100" else 
                  saida_r5 when selout_reg = "101" else 
                  saida_r6 when selout_reg = "110" else 
                  saida_r7;

      end struct;


