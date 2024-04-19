Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity processor_tb is
end entity;

architecture testbench of processor_tb is 

component processor is
port (  clk:           in std_logic; 
        rst:           in std_logic;
        wr_en:         in std_logic;
        mux_sel:       in std_logic;
        p_sel_op:      in unsigned(1 downto 0);   
        p_selin_reg:    in unsigned(2 downto 0);
        p_selout_reg:   in unsigned(2 downto 0);
        mux_pin:       in unsigned(15 downto 0);
        ula_out_debug: out unsigned(15 downto 0));
end component;
    
--signals     
signal  clk, rst, wr_en, mux_sel: std_logic;
signal  p_sel_op: unsigned(1 downto 0);   
signal  p_selin_reg, p_selout_reg: unsigned(2 downto 0);
signal  mux_pin, ula_out_debug: unsigned(15 downto 0);

    begin 
    myprocessor: processor port map (clk => clk, rst => rst, wr_en => wr_en, mux_sel => mux_sel, 
                                    p_sel_op => p_sel_op, p_selin_reg => p_selin_reg, 
                                    p_selout_reg => p_selout_reg, mux_pin => mux_pin, 
                                    ula_out_debug => ula_out_debug);

        process
        begin 
        clk <= '0';

        rst <= '1';
        wait for 5 ns;
        rst <= '0';

        clk <= '0';
        wr_en <= '1';
        mux_sel <= '1';
        p_sel_op <= "00";
        p_selin_reg <= "001";
        p_selout_reg <= "101";
        mux_pin <= "0000000000000100";
        wait for 5 ns;
        clk <= '1'; 
        wait for 5 ns;
        clk <= '0';
        wr_en <= '1';
        mux_sel <= '1';
        p_sel_op <= "00";
        p_selin_reg <= "011"; -- 3 registrador
        p_selout_reg <= "101";
        mux_pin <= "0000000000000111";
        wait for 5 ns;
        clk <= '0';
        wr_en <= '1';
        mux_sel <= '0';
        p_sel_op <= "00";
        p_selin_reg <= "001"; -- primeiro dado que vai para ula é o 4 (que está no registrador) 
        p_selout_reg <= "011"; -- e o segundo é o que está no terceiro registrador (4)
        mux_pin <= "0000000000000000";
        wait for 5 ns;
        clk <= '1';
        
        end process; 


    end testbench;