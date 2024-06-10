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
        0   => B"0011_0001_00000001",  -- LI R1, 1 -- Valor inicial. (address and value)
        1   => B"0011_0010_00000001",  -- LI R2, 1 -- Incremento.
        2   => B"0011_0111_00100001",  -- LI R7, 33 -- Final do loop 
        3   => B"1100_1000_0001_0000", -- MOV A, R1
        4   => B"0010_0001_00000000",  -- SW ($R1)
        5   => B"0100_0000_0010_0000", -- ADD R2 -- incrementa acumulador.
        6   => B"1100_0001_1000_0000", -- MOV R1, A.
        7   => B"0001_0000_0111_0000", -- CMP R7 
        8   => B"0111_0000_11111010",  -- JL -6
        9   => B"0011_0010_00000010",  -- LI R2, 2 -- Valor inicial.
        10  => B"0011_0110_00000000",  -- LI R6, 0 -- Utilizado para zerar a posição de memória apontada pelo endereço.
        11  => B"1100_1000_0010_0000", -- MOV A, R2
        12  => B"1100_0001_1000_0000", -- MOV R1, A 
        13  => B"0100_0000_0010_0000", -- ADD R2  
        14  => B"1100_0001_1000_0000", -- MOV R1, A  
        15  => B"1100_1000_0110_0000", -- MOV A, R6 -- joga zero no acumulador.
        16  => B"0010_0001_00000000",  -- SW ($R1) -- zera o conteúdo apontado por 4. 
        17  => B"1100_1000_0001_0000", -- MOV A, R1
        18  => B"0001_0000_0111_0000", -- CMP R7 
        19  => B"0111_0000_11111001",  -- JL -7
        20  => B"0011_0011_00000001",  -- LI R3, 1 
        21  => B"1100_1000_0010_0000", -- MOV A, R2
        22  => B"0100_0000_0011_0000", -- ADD R3
        23  => B"1100_0010_1000_0000", -- MOV R2, A
        24  => B"0110_0010_00000000",  -- LW ($R2)
        25  => B"0001_0000_0011_0000", -- CMP R3 -- (< 1?)
        26  => B"0111_0000_11111010",  -- JL -6
        27  => B"0001_0000_0111_0000", -- CMP R7 
        28  => B"0111_0000_11101110",  -- JL -18
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
