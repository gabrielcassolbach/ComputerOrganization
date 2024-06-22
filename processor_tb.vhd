library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_tb is
end entity processor_tb;

architecture tesbench of processor_tb is
    component processor is
        port(
            clk           : in std_logic;
            rst           : in std_logic;
            state_out     : out unsigned (1 downto 0);   
            pc_out        : out unsigned (6 downto 0);
            ir_out        : out unsigned(15 downto 0);
            rgbank_out    : out unsigned(15 downto 0);
            acc_out       : out unsigned(15 downto 0);
            ula_out       : out unsigned(15 downto 0)
        );
    end component;

    constant period_time : time      := 5 ns;
    signal   finished    : std_logic := '0';

    -- signals
    signal clk           : std_logic;
    signal rst           : std_logic;
    signal state_out     : unsigned (1 downto 0);   
    signal pc_out        : unsigned (6 downto 0);
    signal ir_out        : unsigned(15 downto 0);
    signal rgbank_out    : unsigned(15 downto 0);
    signal acc_out       : unsigned(15 downto 0);
    signal ula_out       : unsigned(15 downto 0);

    begin
        p : processor port map(
            clk => clk,           
            rst => rst,          
            state_out => state_out,      
            pc_out => pc_out,       
            ir_out => ir_out,       
            rgbank_out => rgbank_out,    
            acc_out => acc_out,     
            ula_out => ula_out
        );
        
        reset_global: process
        begin
            rst <= '1';
            wait for period_time*2; -- espera 2 clocks para garantir
            rst <= '0';
            wait;
        end process;

        sim_time_proc: process
        begin
            wait for 0.1 ms;         -- <== TEMPO TOTAL DA SIMULAÇÃO!!!
            finished <= '1';
            wait;
        end process sim_time_proc;
        
        clk_proc: process
        begin                       -- gera clock até que sim_time_proc termine
            while finished /= '1' loop
                clk <= '0';
                wait for period_time/2;
                clk <= '1';
                wait for period_time/2;
            end loop;
            wait;
        end process clk_proc;
        
end architecture tesbench;