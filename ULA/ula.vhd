Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ula is 
    port (
        data1_in: in unsigned (15 downto 0);
        data2_in: in unsigned (15 downto 0);
        sel_op: in unsigned(1 downto 0);
        data3_out: out unsigned (15 downto 0)
    );
end ula;

architecture struct of ula is 

    begin 
    data3_out <= (data1_in + data2_in)   when sel_op="00" else 
                  (data1_in - data2_in)   when sel_op="01" else 
                  (data1_in xor data2_in) when sel_op="10" else 
                  (data1_in and data2_in) when sel_op="11" else 
                "0000000000000000";
    end struct;