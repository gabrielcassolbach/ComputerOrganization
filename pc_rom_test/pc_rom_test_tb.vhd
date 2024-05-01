library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pc_rom_test_tb is
end entity pc_rom_test_tb;

architecture testbench of pc_rom_test_tb is
    component test is
        port (
            clk : in std_logic;
            wr_en : in std_logic;
            rst : in std_logic;
            test_data_rom_out : out unsigned(15 downto 0)
        );
    end component test;
    
    signal clk : std_logic;
    signal wr_en : std_logic;
    signal rst : std_logic;
    signal test_data_pc_in : unsigned(6 downto 0);
    signal test_data_rom_out : unsigned(15 downto 0);

    begin
        uut : test port map (
            clk => clk,
            wr_en => wr_en,
            rst => rst,
            test_data_rom_out => test_data_rom_out
        );
        process
        begin
            clk <= '0';
            wr_en <= '1';
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
            wait;
        end process;

end architecture testbench;