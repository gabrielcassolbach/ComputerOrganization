Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ula is 
    port (
        data1_in           : in unsigned (15 downto 0);      --data input 1 (reg bank or constant) 
        data2_in           : in unsigned (15 downto 0);      --acumulator
        sel_op             : in unsigned(2 downto 0);        --operator selection
        data3_out          : out unsigned (15 downto 0);     --data output
        carry              : out std_logic                   --carry
        -- overflow           : out std_logic                   --overflow
    );
end ula;

architecture struct of ula is

    -- variáveis temporárias
    signal data1_temp, data2_temp, sum_temp, sub_temp : unsigned(16 downto 0);

begin

    data1_temp <= '0' & data1_in;
    data2_temp <= '0' & data2_in;
    sum_temp <= data2_temp + data1_temp;
    sub_temp <= data2_temp - data1_temp;

    -- resultado da operação
    data3_out <=    sum_temp(15 downto 0)   when sel_op="000" else  -- soma.
                    sub_temp(15 downto 0)   when sel_op="001" else  -- subtração.
                    (data1_in xor data2_in) when sel_op="010" else  -- xor.
                    (data1_in and data2_in) when sel_op="011" else  -- and.
                    (data1_in)              when sel_op="100" else
                    "0000000000000000";
    
    -- carry
    carry <= sum_temp(16) when sel_op = "00" else
             sub_temp(16) when sel_op = "01" else
             '0';

    -- overflow
    -- overflow <= '1' when sel_op = "00" and data1_in(15) = '0' and data2_in(15) = '0' and sum_temp(15) = '1' else
    --             '1' when sel_op = "00" and data1_in(15) = '1' and data2_in(15) = '1' and sum_temp(15) = '0' else
    --             '1' when sel_op = "01" and data1_in(15) = '0' and data2_in(15) = '1' and sub_temp(15) = '1' else
    --             '1' when sel_op = "01" and data1_in(15) = '1' and data2_in(15) = '0' and sub_temp(15) = '0' else
    --             '0';

end struct;