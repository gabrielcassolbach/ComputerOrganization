library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    port(
          increment : in unsigned (7 downto 0);
          data_in  : in unsigned  (6 downto 0);
          data_out : out unsigned (6 downto 0)
    );
 end entity;
 
 architecture struct of adder is 
    begin
        data_out <= (data_in + increment(6 downto 0)) when increment(7) = '0' else 
                    (data_in + increment(6 downto 0)); 
end architecture;