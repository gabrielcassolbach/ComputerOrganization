library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg1bit is
   port( clk      : in std_logic;
         rst      : in std_logic;
         wr_en    : in std_logic;
         data_in  : in std_logic;
         data_out : out std_logic
   );
end entity;

architecture struct of reg1bit is 
    signal value: std_logic := '0';
    begin
        process(clk,rst,wr_en) 
        begin                
            if rst='1' then
                value <= '0';
            elsif wr_en='1' then
                if rising_edge(clk) then
                    value <= data_in;
                end if;
            end if;
        end process;
    
    data_out <= value;  
 end architecture;