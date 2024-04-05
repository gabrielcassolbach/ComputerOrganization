Library IEEE;
use ieee.std_logic_1164.all;

entity bits16adder is
    port (
        a: in std_logic_vector(15 downto 0);
        b: in std_logic_vector(15 downto 0);
        c_in: in std_logic;
        s: out std_logic_vector(16 downto 0)
    );
end bits16adder;

architecture struct of bits16adder is 

--signal 
signal c01, c12, c23, c34, c45, c56, c67, c78, c89: std_logic;
signal c910, c1011, c1112, c1213, c1314, c1415: std_logic;

--component
component bits1adder
port( a, b, ci: in std_logic;
		 cout, s: out std_logic);
end component;

	begin	
    adder0: bits1adder port map (a => a(0), b => b(0), ci=> c_in, cout => c01, s => s(0));
    adder1: bits1adder port map (a => a(1), b => b(1), ci=> c01, cout => c12, s => s(1));
    adder2: bits1adder port map (a => a(2), b => b(2), ci=> c12, cout => c23, s => s(2));
    adder3: bits1adder port map (a => a(3), b => b(3), ci=> c23, cout => c34, s => s(3));
    adder4: bits1adder port map (a => a(4), b => b(4), ci=> c34, cout => c45, s => s(4));
    adder5: bits1adder port map (a => a(5), b => b(5), ci=> c45, cout => c56, s => s(5));
    adder6: bits1adder port map (a => a(6), b => b(6), ci=> c56, cout => c67, s => s(6));
    adder7: bits1adder port map (a => a(7), b => b(7), ci=> c67, cout => c78, s => s(7));
    adder8: bits1adder port map (a => a(8), b => b(8), ci=> c78, cout => c89, s => s(8));
    adder9: bits1adder port map (a => a(9), b => b(9), ci=> c89, cout => c910, s => s(9));
    adder10: bits1adder port map (a => a(10), b => b(10), ci=> c910, cout => c1011, s => s(10));
    adder11: bits1adder port map (a => a(11), b => b(11), ci=> c1011, cout => c1112, s => s(11));
    adder12: bits1adder port map (a => a(12), b => b(12), ci=> c1112, cout => c1213, s => s(12));
    adder13: bits1adder port map (a => a(13), b => b(13), ci=> c1213, cout => c1314, s => s(13));
    adder14: bits1adder port map (a => a(14), b => b(14), ci=> c1314, cout => c1415, s => s(14));
    adder15: bits1adder port map (a => a(15), b => b(15), ci=> c1415, cout => s(16), s => s(15));
	end struct;	