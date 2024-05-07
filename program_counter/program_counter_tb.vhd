library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter_tb is
end entity program_counter_tb;

architecture testbench of program_counter_tb is
    component program_counter is
        port (
            clk : in std_logic;
            wr_en : in std_logic;
            rst : in std_logic;
            increment : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );
    end component program_counter;

    -- signals
    signal clk : std_logic;
    signal wr_en : std_logic;
    signal rst : std_logic;
    signal increment : unsigned(6 downto 0);
    signal data_out : unsigned(6 downto 0);

    begin
        uut : program_counter port map (
            clk => clk,
            wr_en => wr_en,
            rst => rst,
            increment => increment,
            data_out => data_out
        );
        process
        begin
            clk <= '0';
            rst <= '0';
            wr_en <= '1';
            increment <= "0000001";
            wait for 5 ns;
            increment <= "0000001";
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            increment <= "0000001";
            clk <= '1';
            wait for 5 ns;
            increment <= "0000001";
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait;
        end process;
end architecture testbench;