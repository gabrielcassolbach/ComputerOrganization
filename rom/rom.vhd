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
        0  => B"0011_0011_0000_0100", -- LI  R3, 4.
        1  => B"0011_0100_0000_1000", -- LI  R4, 8
        2  => B"1100_1000_0011_0000", -- MOV A, R3 
        3  => B"0100_0000_0100_0000", -- ADD R4 
        4  => B"1100_0101_1000_0000", -- MOV R5, A
        5  => B"0011_0010_0000_0001", -- LI  R2, 1
        6  => B"0101_0000_0010_0000", -- SUB R2
        7  => B"1100_0101_1000_0000", -- MOV R5, A
        8  => B"1111_0000_0_0010100", -- JMP 0X14
        9 => B"0011_0101_0000_0000",  -- LI R5, 0
        20 => B"1100_1000_0101_0000", -- MOV A, R5
        21 => B"1100_0011_1000_0000", -- MOV R3, A
        22 => B"1111_0000_0_0000010", -- JMP 0X02
        23 => B"0011_0011_0000_0000", -- LI R3, 0
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