library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity rom_tb;

architecture testbench of rom_tb is
    component rom is
        port (
            clk : in std_logic;
            address : in unsigned(6 downto 0);
            data : out unsigned(15 downto 0)
        );
    end component;
    
    -- signals
    signal clk : std_logic;
    signal address : unsigned(6 downto 0);
    signal data : unsigned(15 downto 0);

    begin
        -- instantiate the unit under test
        uut : rom port map (
            clk => clk,
            address => address,
            data => data
        );
        process
        begin
            -- clock generation
            clk <= '0';
            wait for 5 ns;
            address <= "0000000";
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            address <= "0000001";
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
            address <= "0000010";
            clk <= '1';
            wait for 5 ns;
            wait;
        end process;
end architecture testbench;


        