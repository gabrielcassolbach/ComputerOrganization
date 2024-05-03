library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- 0 => Fetch, 1 => Decode/Execute

entity state_machine is
    port (
        clk : in std_logic;
        rst : in std_logic;
        state : out std_logic
    );
end entity state_machine;

architecture a_state_machine of state_machine is
    signal state_s : std_logic := '0';
begin
    process (clk, rst)
    begin
        if rising_edge(clk) then
            state_s <= not state_s  ;
        end if;
    end process;
    state <= state_s;
end architecture a_state_machine;