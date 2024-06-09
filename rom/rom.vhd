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
        0  => B"0011_0011_00011110",   -- LI R3, 30 -- Endereço inicial. -- ok
        1  => B"0011_0010_00001010",   -- LI R2, 10 -- Valor que será colocado na RAM. -- ok
        2  => B"1100_1000_0010_0000",  -- MOV A, R2 -- Valor  -- ok.
        3  => B"0010_0011_00000000",   -- SW ($R3) -> (Store.) Carrega o valor do acumulador na RAM no endereço apontado por R3. 
        4  => B"1100_1000_0001_0000",   -- MOV A, R1 -- Zera o Acumulador.
        5  => B"0110_0011_00000000",   -- LW ($R3) -> 
        6  => B"1100_0101_1000_0000",  -- MOV R5, A -- deve aparecer 10.
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
