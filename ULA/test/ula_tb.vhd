Library ieee;
use ieee.std_logic_1164.all;

entity ula_tb is
end entity;

architecture testbench of ula_tb is 

--component 
component ula is 
port (  data1_in: in std_logic_vector (15 downto 0);
        data2_in: in std_logic_vector (15 downto 0);
        operation: in std_logic_vector (3 downto 0);
        data3_out: out std_logic_vector (15 downto 0));
end component;

--signals
signal data1_in: std_logic_vector (15 downto 0);
signal data2_in: std_logic_vector (15 downto 0);
signal operation: std_logic_vector (3 downto 0);
signal data3_out: std_logic_vector (15 downto 0);

    begin 
    ula01: ula port map (data1_in, data2_in, operation, data3_out);

    process 
    begin 
        data1_in <= "0000000000000000";
        data2_in <= "0000000000000001";
        wait for 5 ns;
    end process;

    end testbench;