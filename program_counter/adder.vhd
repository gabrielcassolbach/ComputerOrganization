library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity adder is
    port( clk      : in std_logic;
          data_in  : in unsigned  (15 downto 0);
          data_out : out unsigned (15 downto 0)
    );
 end entity;
 
 architecture struct of adder is 
     begin
        process(clk)
        begin
            if(rising_edge(clk)) then
                data_out <= data_in + 1; 
            end if;
        end process;
     end struct;