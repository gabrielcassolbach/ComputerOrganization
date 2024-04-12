Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity ula_tb is
end entity;

architecture testbench of ula_tb is 

--component 
component ula is 
port (  data1_in: in unsigned (15 downto 0);
        data2_in: in unsigned (15 downto 0);
        sel_op: in unsigned(1 downto 0);
        data3_out: out unsigned (15 downto 0));
end component;

--signals
signal data1_in: unsigned (15 downto 0);
signal data2_in: unsigned (15 downto 0);
signal sel_op: unsigned   (1 downto 0);
signal data3_out: unsigned (15 downto 0);

    begin 
    ula01: ula port map (data1_in, data2_in, sel_op, data3_out);

    process 
    begin 
        data1_in <= "0000000000000000";
        data2_in <= "0000000000000001";
        sel_op <= "00";
        wait for 5 ns;
        data1_in <= "0000000000000000";
        data2_in <= "0000000000000001";
        sel_op <= "01";
        wait for 5 ns;
        data1_in <= "0000000000000000";
        data2_in <= "0000000000000001";
        sel_op <= "10";
        wait for 5 ns;
        data1_in <= "0000000000000000";
        data2_in <= "0000000000000001";
        sel_op <= "11";
        wait for 5 ns;
    end process;

    end testbench;