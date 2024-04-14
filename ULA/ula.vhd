Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ula is 
    port (
        data1_in, data2_in : in unsigned (15 downto 0);      --entrada de dados
        sel_op             : in unsigned(1 downto 0);        --seleção de operação
        data3_out          : out unsigned (15 downto 0);     --resultado da operação
        carry              : out std_logic;                  --carry
        overflow           : out std_logic                   --overflow
    );
end ula;

architecture struct of ula is

    -- variáveis temporárias
    signal data1_temp, data2_temp, sum_temp, sub_temp : unsigned(16 downto 0);

begin

    data1_temp <= '0' & data1_in;
    data2_temp <= '0' & data2_in;
    sum_temp <= data1_temp + data2_temp;
    sub_temp <= data1_temp - data2_temp;

    -- resultado da operação
    data3_out <=    sum_temp(15 downto 0)   when sel_op="00" else 
                    sub_temp(15 downto 0)   when sel_op="01" else 
                    (data1_in xor data2_in) when sel_op="10" else 
                    (data1_in and data2_in) when sel_op="11" else 
                    "0000000000000000";
    
    -- carry (quando a operação é de subtração, o carry é 1 se data2_in > data1_in, 0 caso contrário)
    carry <=    sum_temp(16) when sel_op = "00"                          else
                '0'          when sel_op = "01" and data2_in <= data1_in else
                '1'          when sel_op = "01" and data2_in > data1_in  else
                '0';

    -- overflow
    overflow <= '1' when sel_op = "00" and data1_in(15) = '0' and data2_in(15) = '0' and sum_temp(15) = '1' else
                '1' when sel_op = "00" and data1_in(15) = '1' and data2_in(15) = '1' and sum_temp(15) = '0' else
                '1' when sel_op = "01" and data1_in(15) = '0' and data2_in(15) = '1' and sub_temp(15) =  '1' else
                '1' when sel_op = "01" and data1_in(15) = '1' and data2_in(15) = '0' and sub_temp(15) =  '0' else
                '0';


end struct;