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
        0  => "0000000000000001",
        1  => "0000000000000010",
        2  => "0000000000000100",
        3  => "0000000000001000",
        4  => "0000000000010000",
        5  => "0000000000100000",
        6  => "0000000001000000",
        7  => "0000000010000000",
        8  => "0000000100000000",
        9  => "0000001000000000",
        10 => "0000100000000000",
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