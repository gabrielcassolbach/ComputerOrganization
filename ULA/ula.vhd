Library IEEE;
use ieee.std_logic_1164.all;

entity ula is 
    port (
        data1_in: in std_logic_vector (15 downto 0);
        data2_in: in std_logic_vector (15 downto 0);
        operation: in std_logic_vector (3 downto 0);
        data3_out: out std_logic_vector (15 downto 0)
    );
end ula;

architecture struct of ula is 

-- signal.
signal sumOutput: std_logic_vector (16 downto 0);

-- component.
component bits16adder is
port (  a: in std_logic_vector(15 downto 0);
        b: in std_logic_vector(15 downto 0);
        c_in: in std_logic;
        s: out std_logic_vector(16 downto 0));
end component;

    begin 
    adder: bits16adder port map (a => data1_in, b => data2_in, c_in => '0', s => sumOutput);
    data3_out <= sumOutput(15 downto 0);
    --data3_out <= "1000000000000000";
    end struct;