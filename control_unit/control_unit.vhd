-- Control Unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        opcode      : in unsigned(3 downto 0);      -- opcode from instruction memory (ROM)
        state       : out std_logic;                -- for debugging
        pc_wr       : out std_logic;
        jump_sel    : out std_logic;                -- jump signal
        nop_sel     : out std_logic                 -- no operation signal
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
        
        -- instruction format: 16 bits
        -- 15-12: opcode
        -- 11-0: to be defined ...

        -- Output signals
        pc_wr <= '1' when state_s = '1' else '0';

        jump_sel <= '1' when opcode = "1111" else '0'; -- inconditional jump (absolute)
        nop_sel  <= '1' when opcode = "0000" else '0'; -- no operation
        
        state <= state_s;

end control_unit_a;