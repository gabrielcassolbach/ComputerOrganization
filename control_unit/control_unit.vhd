-- Control Unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        instruction : in  unsigned (15 downto 0);
        state       : out unsigned (1 downto 0); -- debug
        selin_reg   : out unsigned (2 downto 0);
        selout_reg  : out unsigned (2 downto 0);
        pc_wr       : out std_logic;
        ir_wr       : out std_logic;
        reg_bank_wr : out std_logic;
        acc_wr_en   : out std_logic;
        acc_rst     : out std_logic;
        imm_sel     : out std_logic;
        mux_reg_cte_sel: out std_logic;
        ula_sel_op  : out unsigned (1 downto 0);  
        ula_in_sel  : out std_logic;
        acc_in_sel  : out std_logic;
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
            state  : out  unsigned(1 downto 0)
        );
    end component;

    -- Signals declaration
    signal state_s :  unsigned(1 downto 0) := "10";   
    signal opcode_s: unsigned(3 downto 0);
    
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
        opcode_s <= instruction (15 downto 12);
        -- 11-8: registrador 1. => 0{011}
        selin_reg <=  instruction (10 downto 8); 
        -- 7-4: registrador 2.  => 0{100}
        selout_reg <= instruction (6 downto 4);
        -- 3-0: constante.

        -- Output signals
        pc_wr <= '1' when state_s = "00" else '0';
        ir_wr <= '1' when state_s = "00" else '0';
        reg_bank_wr <= '1' when state_s = "10" else '0';

        acc_in_sel <= '1' when instruction (11 downto 8) = "1000" else
                      '0'; 
        
        ula_in_sel <= '1' when opcode_s = "1100" else '0'; 
        
        acc_rst <= '1' when opcode_s = "1100" and state_s = "00" else '0';
        acc_wr_en <= '0' when opcode_s = "0011" and state_s = "01" else '1';
        
        -- adiconar operação na ULA.
        ula_sel_op <= "00" when opcode_s = "1100" else "00"; -- MOV. (SOMA)

        imm_sel <= instruction (8);
        
        jump_sel <= '1' when opcode_s = "1111" else '0'; -- inconditional jump (absolute)
        nop_sel  <= '1' when opcode_s = "0000" else '0'; -- no operation
        
        state <= state_s;

end control_unit_a;