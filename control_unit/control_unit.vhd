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
        mux_cte_acc_out_sel     : out std_logic;
        mux_reg_cte_sel: out std_logic;
        ula_sel_op  : out unsigned (2 downto 0);  
        ula_in_sel  : out std_logic;
        acc_in_sel  : out std_logic;                -- control signal on the mux for the accumulator input
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
    signal opcode_s: unsigned(3 downto 0) := "0000";
    
    -- Components instantiation
    begin
        state_machine_inst : state_machine
        port map(
            clk    => clk,
            rst    => rst,
            state  => state_s
        );
        
        -- instruction format: 16 bits
        opcode_s <= instruction (15 downto 12);
                                                    
        selin_reg <=  instruction (10 downto 8); 

        selout_reg <= instruction (6 downto 4);

        -- Output signals
        pc_wr <= '1' when state_s = "00" or (opcode_s = "1111" and state_s = "01") else '0';
        
        ir_wr <= '1' when state_s = "00" else '0';
        
        -- MOV instruction (MOV R3, A) or LI instruction
        reg_bank_wr <= '1' when ((opcode_s  = "1100" and instruction(7 downto 4) = "1000") or opcode_s = "0011") and state_s = "10" else '0';  

        -- control signal on the mux for the accumulator input
        acc_in_sel <= '1' when instruction (11 downto 8) = "1000" or (opcode_s = "0100") or (opcode_s = "0101")  else '0';  
        
        ula_in_sel <= '1' when (opcode_s = "1100" or opcode_s = "0100" or opcode_s = "0101") else '0'; 
            
        acc_wr_en <= '1' when (opcode_s /= "0011" and state_s = "10" and instruction(7 downto 4) /= "1000") else '0'; 
                      
        ula_sel_op <= "000" when opcode_s = "0100" else
                      "001" when opcode_s = "0101" else
                      "100" when opcode_s = "1100" else 
                      "000";

        mux_cte_acc_out_sel <= '0' when (opcode_s = "0011") else '1';
        
        jump_sel <= '1' when opcode_s = "1111" else '0'; -- inconditional jump (absolute)
        
        nop_sel  <= '1' when opcode_s = "0000" else '0'; -- no operation
        
        state <= state_s;

end control_unit_a;