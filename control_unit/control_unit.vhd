-- Control Unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        state   : out std_logic;    -- for debugging
        pc_wr   : out std_logic
    );
end control_unit;

architecture control_unit_a of control_unit is
    -- Components declaration
    component state_machine is
        port(
            clk    : in std_logic;
            rst    : in std_logic;
            state  : out std_logic
        );
    end component;

    -- Signals declaration
    signal state_s : std_logic;
    
    -- Components instantiation
    begin
        state_machine_inst : state_machine
        port map(
            clk    => clk,
            rst    => rst,
            state  => state_s
        );

        -- Output signals
        state <= state_s;
        pc_wr <= '1' when state_s = '1' else '0';
end control_unit_a;