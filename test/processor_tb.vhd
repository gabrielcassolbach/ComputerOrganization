Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity processor_tb is
end entity;

architecture testbench of processor_tb is 

component processor is
port (  clk:                in std_logic; 
        rst:                in std_logic;
        wr_en:              in std_logic;
        cte:                in unsigned(15 downto 0);
        data_reg_input:     in unsigned(15 downto 0);
        mux_cte_regs_sel:   in std_logic;
        mux_cte_ula_sel:    in std_logic; 
        p_sel_op:           in unsigned(1 downto 0);   
        p_selin_reg:        in unsigned(2 downto 0);
        p_selout_reg:       in unsigned(2 downto 0);
        ula_out_debug:      out unsigned(15 downto 0));
end component;
    
--signals     
signal  clk, rst, wr_en, mux_cte_regs_sel, mux_cte_ula_sel: std_logic;
signal  p_sel_op: unsigned(1 downto 0);   
signal  p_selin_reg, p_selout_reg: unsigned(2 downto 0);
signal  cte, data_reg_input, ula_out_debug: unsigned(15 downto 0);

    begin 
    myprocessor: processor port map (
        clk => clk, 
        rst => rst, 
        wr_en => wr_en, 
        cte => cte,
        data_reg_input => data_reg_input,
        mux_cte_regs_sel => mux_cte_regs_sel,
        mux_cte_ula_sel => mux_cte_ula_sel,
        p_sel_op => p_sel_op, 
        p_selin_reg => p_selin_reg, 
        p_selout_reg => p_selout_reg, 
        ula_out_debug => ula_out_debug);

        process
        begin 
            clk <= '0';
            rst <= '1';
            cte <= "0000000000000100";
            mux_cte_regs_sel <= '1';
            mux_cte_ula_sel <= '0';
            wr_en <= '0';
            wait for 5 ns;
            rst <= '0';
            clk <= '1';
            wr_en <= '1';
            cte <= "0000000000000100";
            data_reg_input <= "0000000000000001";
            mux_cte_regs_sel <= '1';
            mux_cte_ula_sel <= '0';
            p_sel_op <= "00";
            p_selin_reg <= "001";
            p_selout_reg <= "001";
            wait for 5 ns;
            clk <= '0';
            rst <= '1';
            wait for 5 ns;
            rst <= '0';
            clk <= '1';
            wr_en <= '1';
            cte <= "0000000000000100";
            data_reg_input <= "0000000000000001";
            mux_cte_regs_sel <= '0';
            mux_cte_ula_sel <= '0';
            p_sel_op <= "00";
            p_selin_reg <= "001";
            p_selout_reg <= "001";
            wait for 5 ns;
            clk <= '0';
            rst <= '1';
            wait for 5 ns;
            rst <= '0';
            clk <= '1';
            wr_en <= '1';
            cte <= "0000000000000100";
            data_reg_input <= "0000000000000001";
            mux_cte_regs_sel <= '1';
            mux_cte_ula_sel <= '1';
            p_sel_op <= "00";
            p_selin_reg <= "001";
            p_selout_reg <= "001";
            wait for 5 ns;
            wait;
    end process; 
end testbench;