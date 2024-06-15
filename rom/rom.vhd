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
        0   => B"0011_0111_00100110",  -- LI R7, 38 -- Valor inicial
        1   => B"0011_0010_11111111",  -- LI R2, 255 -- Incremento.
        2   => B"0011_0100_00011011",  -- LI R4, 27  -- End of Loop.
        3   => B"0011_0011_00000001",  -- LI R3, 1  -- iteration of Loop.
        4   => B"0011_0101_00000001",  -- LI R5, 1  -- Increment of Loop.
        5   => B"1100_1000_0111_0000", -- MOV A, R7 
        6   => B"0100_0000_0010_0000", -- ADD R2  
        7   => B"1100_0111_1000_0000", -- MOV R7, A
        8   => B"1100_1000_0011_0000", -- MOV A, R3
        9   => B"0100_0000_0101_0000", -- ADD R5 
        10  => B"1100_0011_1000_0000", -- MOV R3, A
        11  => B"0001_0000_0100_0000", -- CMP R4 
        12  => B"0111_0000_11111000",  -- JL -8
        13  => B"0011_0101_00111100",  -- LI R5, 60.
        14  => B"0011_0001_00000001",  -- LI R1, 1 -- Valor inicial. (address and value)
        15  => B"0011_0010_00000001",  -- LI R2, 1 -- Incremento.
        16  => B"1100_1000_0001_0000", -- MOV A, R1
        17  => B"0010_0001_00000000",  -- SW ($R1)
        18  => B"0100_0000_0010_0000", -- ADD R2 -- incrementa acumulador.
        19  => B"1100_0001_1000_0000", -- MOV R1, A.
        20  => B"0001_0000_0111_0000", -- CMP R7 
        21  => B"0111_0000_11111010",  -- JL -6
        22  => B"0011_0010_00111011",  -- LI R2, 59 -- Valor inicial.
        23  => B"0011_0110_00000000",  -- LI R6, 0 -- Utilizado para zerar a posição de memória apontada pelo endereço.
        24  => B"1100_1000_0010_0000", -- MOV A, R2
        25  => B"1100_0001_1000_0000", -- MOV R1, A 
        26  => B"0100_0000_0010_0000", -- ADD R2  
        27  => B"1100_0001_1000_0000", -- MOV R1, A  
        28  => B"1100_1000_0110_0000", -- MOV A, R6 -- joga zero no acumulador.
        29  => B"0010_0001_00000000",  -- SW ($R1) 
        30  => B"1100_1000_0001_0000", -- MOV A, R1
        31  => B"0001_0000_0111_0000", -- CMP R7 
        32  => B"0111_0000_11111001",  -- JL -7
        --33  => B"0011_0011_00000001",  -- LI R3, 1 
        --34  => B"1100_1000_0010_0000", -- MOV A, R2
        --35  => B"0100_0000_0011_0000", -- ADD R3
        --36  => B"1100_0010_1000_0000", -- MOV R2, A
        --37  => B"0110_0010_00000000",  -- LW ($R2)
        --38  => B"0001_0000_0011_0000", -- CMP R3 -- (< 1?)
        --39  => B"0111_0000_11111010",  -- JL -6
        --40  => B"0001_0000_0101_0000", -- CMP R5 
        --41  => B"0111_0000_11101110",  -- JL -18
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
