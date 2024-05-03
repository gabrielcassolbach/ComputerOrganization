library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit_tb is
end entity control_unit_tb;

architecture tesbench of control_unit_tb is
    component control_unit is
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            state   : out std_logic;    -- for debugging
            pc_wr   : out std_logic
        );
    end component;

    -- signals
    signal clk : std_logic;
    signal rst : std_logic;
    signal state : std_logic;
    signal pc_wr : std_logic;

    begin
        uut : control_unit port map(
            clk => clk,
            rst => rst,
            state => state,
            pc_wr => pc_wr
        );
        process
        begin
            clk <= '0';
            rst <= '1';
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