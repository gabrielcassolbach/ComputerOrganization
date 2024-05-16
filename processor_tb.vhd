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
        process
        begin
            rst <= '1';
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            rst <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            wait;
        end process;
end architecture tesbench;