library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_tb is
end entity ula_tb;

architecture testbench of ula_tb is
    component ula is
        port (
            data1_in           : in unsigned (15 downto 0);      --entrada de dados
            data2_in           : in unsigned (15 downto 0);      --acumulador
            sel_op             : in unsigned(2 downto 0);        --seleção de operação
            data3_out          : out unsigned (15 downto 0);     --resultado da operação
            carry              : out std_logic;                  --carry
            overflow           : out std_logic                   --overflow
        );
    end component ula;

    -- signals
    signal data1_in, data2_in : unsigned (15 downto 0);
    signal sel_op             : unsigned (2 downto 0);
    signal data3_out          : unsigned (15 downto 0);
    signal carry              : std_logic;
    signal overflow           : std_logic;

    begin
        uut : ula port map (
            data1_in => data1_in,
            data2_in => data2_in,
            sel_op => sel_op,
            data3_out => data3_out,
            carry => carry,
            overflow => overflow
        );
        process
        begin
            data1_in <= "0000000000000001";
            data2_in <= "0000000000000001";
            sel_op <= "000";
            wait for 5 ns;
            data1_in <= "0000000000000001";
            data2_in <= "0000000000000000";
            sel_op <= "001";
            wait for 5 ns;
            data1_in <= "0000000000000001";
            data2_in <= "1111111111111111";
            sel_op <= "001";
            wait for 5 ns;
            wait;
        end process;
    end architecture testbench;