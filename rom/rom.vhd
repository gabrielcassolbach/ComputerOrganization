library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is
    port (
        clk : in std_logic;
        address : in unsigned(6 downto 0);
        data : out unsigned(15 downto 0)
    );
end entity rom;

architecture a_rom of rom is
    type memory is array (0 to 127) of unsigned(15 downto 0);
    constant rom_data : memory := (
        0  => B"0000000000000000",
        1  => B"0011_0011_0000_0100", -- LI  R3, 4.
        2  => B"1100_1000_0011_0000", -- MOV A, R3.
        3  => B"0000_0000_0000_0000",
        4  => B"0000_0000_0000_0000",
        5  => B"0000_000000000000",
        6  => B"0000_000001000000",
        7  => B"0000_000010000000",
        8  => B"0000_000100000000",
        9  => B"0000_001000000000",
        10 => B"0000_100000000000",
        others => (others=>'0')
    );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            data <= rom_data(to_integer(address));
        end if;
    end process;
end architecture a_rom;