-- Control Unit
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control_unit is 
    port(
        clk                     : in std_logic;
        rst                     : in std_logic;
        instruction             : in  unsigned (15 downto 0);
        ula_out                 : in  unsigned (15 downto 0);   -- output of the ULA (NEEDS TO BE IMPLEMENTED)
        ula_carry               : in  std_logic;                -- carry signal from the ULA (NEEDS TO BE IMPLEMENTED)
        state                   : out unsigned (1 downto 0);    -- current state
        selin_reg               : out unsigned (2 downto 0);    -- register input selection on register bank
        selout_reg              : out unsigned (2 downto 0);    -- register output selection on register bank
        pc_wr                   : out std_logic;                -- write enable signal for the program counter
        ir_wr                   : out std_logic;                -- write enable signal for the instruction register
        reg_bank_wr             : out std_logic;                -- write enable signal for the register bank
        acc_wr_en               : out std_logic;                -- write enable signal for the accumulator
        -- acc_rst                 : out std_logic;               
        mux_cte_acc_out_sel     : out std_logic;                -- control signal for the mux that selects the constant or the accumulator output
        mux_reg_cte_sel         : out std_logic;                -- control signal for the mux that selects the register bank out or the constant
        ula_sel_op              : out unsigned (2 downto 0);    -- operation selection on the ULA
        ula_in_sel              : out std_logic;                -- control signal for the mux that selects the constant or the register bank out
        acc_in_sel              : out std_logic;                -- control signal on the mux for the accumulator input
        jump_sel                : out std_logic;                -- jump signal (unconditional jump)(absolute)
        branch_sel              : out std_logic;                -- branch signal (conditional jump)(relative)(NEEDS TO BE IMPLEMENTED)
        nop_sel                 : out std_logic                 -- no operation signal
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
    component reg1bit is
        port(
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in std_logic;
            data_out : out std_logic
        );
    end component;

    -- Signals declaration
    signal state_s :  unsigned(1 downto 0) := "10";   
    signal opcode_s: unsigned(3 downto 0) := "0000";
    signal negative_flag_in_s : std_logic;
    signal zero_flag_in_s : std_logic;
    signal negative_flag_out_s : std_logic;
    signal zero_flag_out_s : std_logic;
    signal flags_wr_en_s : std_logic;
    
    -- Components instantiation
    begin
        state_machine_inst : state_machine
            port map(
                clk    => clk,
                rst    => rst,
                state  => state_s
            );
        negative_flag : reg1bit
            port map(
                clk      => clk,
                rst      => rst,
                wr_en    => flags_wr_en_s,
                data_in  => negative_flag_in_s,
                data_out => negative_flag_out_s
            );
        zero_flag : reg1bit
            port map(
                clk      => clk,
                rst      => rst,
                wr_en    => flags_wr_en_s,
                data_in  => zero_flag_in_s,
                data_out => zero_flag_out_s
            );

        -- instruction format: 16 bits
        opcode_s <= instruction (15 downto 12);
                                                    
        selin_reg <=  instruction (10 downto 8); 

        selout_reg <= instruction (6 downto 4);


        -- Flags
        flags_wr_en_s <= '1' when (opcode_s = "0001" and state_s = "01") else '0'; -- CMP instruction

        negative_flag_in_s <= '1' when ula_carry = '1' else '0';
        
        zero_flag_in_s <= '1' when ula_out = "000000000000000" else '0';


        -- Output signals

        -- Write enable signals
        pc_wr <= '1' when state_s = "00" or ((opcode_s = "1111" or opcode_s = "0111") and state_s = "01") else '0';

        ir_wr <= '1' when state_s = "00" else '0';
                
        -- MOV instruction (MOV R3, A) or LI instruction
        reg_bank_wr <= '1' when ((opcode_s  = "1100" and instruction(7 downto 4) = "1000") or opcode_s = "0011") and state_s = "10" else '0';  

        acc_wr_en <= '1' when (opcode_s /= "0011" and state_s = "10" and instruction(7 downto 4) /= "1000" and opcode_s /= "0001"  and opcode_s /= "0111") else '0'; 
        

        -- selectors for the muxes
        acc_in_sel <= '1' when (instruction (11 downto 8) = "1000" or (opcode_s = "0100") or (opcode_s = "0101"))  else '0';  
        
        ula_in_sel <= '1' when (opcode_s = "1100" or opcode_s = "0100" or opcode_s = "0101" or opcode_s = "0001") else '0'; 
        
        mux_cte_acc_out_sel <= '0' when (opcode_s = "0011") else '1';
        

        -- Instruction selection
        jump_sel <= '1' when opcode_s = "1111" else '0'; -- inconditional jump (absolute)
        
        branch_sel <= '1' when (opcode_s = "0111" and negative_flag_in_s = '1') else '0'; -- relative jump (inconditional)
        
        nop_sel  <= '1' when opcode_s = "0000" else '0'; -- no operation
        
        ula_sel_op <= "000" when opcode_s = "0100" else
        "001" when (opcode_s = "0101" or opcode_s = "0001") else
        "100" when opcode_s = "1100" else 
        "000";
        
        state <= state_s;

        end control_unit_a;