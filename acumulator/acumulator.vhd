library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity acumulator is
   port( clk      : in std_logic;
         rst      : in std_logic;
         wr_en    : in std_logic;
         acumulator_in  : in unsigned(15 downto 0);
         acumulator_out : out unsigned(15 downto 0)
   );
end entity;

architecture struct of acumulator is 
    signal values: unsigned(15 downto 0);
    begin
        process(clk,rst,wr_en) 
        begin                
            if rst='1' then
                values <= "0000000000000000";
            elsif wr_en='1' then
                if rising_edge(clk) then
                    values <= acumulator_in;
                end if;
            end if;
        end process;
    
    acumulator_out <= values;  
 end architecture;