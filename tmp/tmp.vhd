library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tmp is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        state         : out unsigned (1 downto 0);   
        pc_out        : out unsigned (6 downto 0);
        ir_out        : out unsigned(15 downto 0);
        rgbank_out    : out unsigned(15 downto 0);
        acc_out       : out unsigned(15 downto 0);
        ula_out       : out unsigned(15 downto 0)
    );
end entity tmp;

--architecture test_a of test is
architecture tmp_a of tmp is

    




end architecture tmp_a;
