library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_rom_test_tb is
end entity pc_rom_test_tb;

architecture testbench of pc_rom_test_tb is
    component test is
        port (
            clk : in std_logic;
            rst : in std_logic;
            cu_state : out std_logic;    -- for debugging
            rom_data_out : out unsigned(15 downto 0)
        );
    end component test;
    
    signal clk : std_logic;
    signal rst : std_logic;
    signal cu_state : std_logic;
    signal rom_data_out : unsigned(15 downto 0);

    begin
        uut : test port map (
            clk => clk,
            rst => rst,
            cu_state => cu_state,
            rom_data_out => rom_data_out
        );
        process
        begin
            -- Loop through address o and 5
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
        end process;

end architecture testbench;