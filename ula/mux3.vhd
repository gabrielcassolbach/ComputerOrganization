library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux3 is 
    port( 
        control_signal: in unsigned(1 downto 0); 
        a, b, c: in unsigned (15 downto 0);
        d: out unsigned (15 downto 0)
    );
end mux3;

architecture struct of mux3 is 

begin
    d <= a when control_signal = "00" else
         b when control_signal = "01" else
         c when control_signal = "10";
end struct;