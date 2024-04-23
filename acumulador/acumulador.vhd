library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity acumulador is
   port( clk      : in std_logic;
         rst      : in std_logic;
         wr_en    : in std_logic;
         acumulador_in  : in unsigned(15 downto 0);
         acumulador_out : out unsigned(15 downto 0)
   );
end entity;

architecture struct of acumulador is 
    signal registro: unsigned(15 downto 0);
    begin
        process(clk,rst,wr_en) 
        begin                
            if rst='1' then
                registro <= "0000000000000000";
            elsif wr_en='1' then
                if rising_edge(clk) then
                    registro <= acumulador_in;
                end if;
            end if;
        end process;
    
    acumulador_out <= registro;  
 end architecture;