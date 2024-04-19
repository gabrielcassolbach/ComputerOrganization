library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux is 
    port( 
        control_signal: in std_logic; 
        a, b: in unsigned (15 downto 0);
        c: out unsigned (15 downto 0)
    );
end mux;

architecture struct of mux is 

begin
    c <= b when control_signal = '1' else a;
end struct;