library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test is
    port (
        clk : in std_logic;
        wr_en : in std_logic;
        rst : in std_logic;
        test_data_rom_out : out unsigned(15 downto 0)
    );
end entity test;

architecture test_a of test is
    component program_counter is
        port (
            clk : in std_logic;
            wr_en : in std_logic;
            rst : in std_logic;
            data_out : out unsigned(6 downto 0)
        );
    end component program_counter;
    component rom is
        port (
            clk : in std_logic;
            address : in unsigned(6 downto 0);
            data : out unsigned(15 downto 0)
        );
    end component rom;
    
    -- signal declarations
    signal data_out_s: unsigned(6 downto 0);

begin
    -- component instantiation
    pc : program_counter
        port map (
            clk => clk,
            wr_en => wr_en,
            rst => rst,
            data_out => data_out_s
        );
    mem_rom : rom
        port map (
            clk => clk,
            address => data_out_s,
            data => test_data_rom_out
        );
end architecture test_a;
