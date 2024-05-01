library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity state_machine_tb is 
end entity state_machine_tb;

architecture testbench of state_machine_tb is
    component state_machine is
        port (
            clk: in std_logic;
            reset: in std_logic;
            state: out std_logic
        );
    end component state_machine;

    -- signals
    signal clk: std_logic;
    signal reset: std_logic;
    signal state: std_logic;

    begin
        -- instantiate the unit under test
        uut: state_machine port map (
            clk => clk,
            reset => reset,
            state => state
        );

        process
        begin
            -- initialize the clock
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            wait;
        end process;
end architecture testbench;