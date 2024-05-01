library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg7bits is
   port( clk      : in std_logic;
         rst      : in std_logic;
         wr_en    : in std_logic;
         data_in  : in unsigned(6 downto 0);
         data_out : out unsigned(6 downto 0)
   );
end entity;

architecture struct of reg7bits is 
    signal values: unsigned(6 downto 0) := "0000000";
    begin
        process(clk,rst,wr_en) 
        begin                
            if rst='1' then
                values <= "0000000";
            elsif wr_en='1' then
                if rising_edge(clk) then
                    values <= data_in;
                end if;
            end if;
        end process;
    
    data_out <= values;  
 end architecture;