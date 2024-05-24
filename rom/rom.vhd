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
        0  => B"0011_0011_0000_0000", -- LI  R3, 0 -- Valor inicial.
        1  => B"0011_0100_0000_0000", -- LI  R4, 0 -- Valor inicial.
        2  => B"0011_0110_0000_0001", -- LI  R6, 1 -- Incremento.
        3  => B"0011_0010_0000_0100", -- LI  R2, 4 -- Constante comparadora.
        4  => B"1100_1000_0011_0000", -- MOV A, R3
        5  => B"0100_0000_0100_0000", -- ADD R4 
        6  => B"1100_0100_1000_0000", -- MOV R4, A 
        7  => B"1100_1000_0011_0000", -- MOV A, R3
        8  => B"0100_0000_0110_0000", -- ADD R6 
        9  => B"1100_0011_1000_0000", -- MOV R3, A
        10 => B"1100_1000_0011_0000", -- MOV A, R3
        11 => B"0001_0000_0010_0000", -- CMP R2
        12 => B"0111_0000_11110111",  -- JL -9
        13 => B"1100_1000_0100_0000", -- MOV A, R4
        14 => B"1100_0101_1000_0000", -- MOV R5, A
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

--11111000