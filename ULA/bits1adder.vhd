Library IEEE;
use ieee.std_logic_1164.all;

entity bits1adder is
	port (
		a, b, ci: in std_logic;
		cout, s: out std_logic 
	);
end bits1adder;

architecture gate_level of bits1adder is
	
    begin
		cout <= ((a and b) or (ci and (a or b)));
		s <= ((a xor b) xor ci);
	end gate_level;
