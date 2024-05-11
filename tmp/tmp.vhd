library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;

entity tmp is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        state_out     : out unsigned (1 downto 0);   
        pc_out        : out unsigned (6 downto 0);
        ir_out        : out unsigned(15 downto 0);
        rgbank_out    : out unsigned(15 downto 0);
        acc_out       : out unsigned(15 downto 0);
        ula_out       : out unsigned(15 downto 0)
    );
end entity tmp;

--architecture test_a of test is
architecture tmp_a of tmp is

    ---------------------------------------------
    --components declarations: 
    component program_counter is
        port (
            clk : in std_logic;
            wr_en : in std_logic;
            rst : in std_logic;
            increment : in unsigned(6 downto 0);
            data_out : out unsigned(6 downto 0)
        );
    end component program_counter;

    component rom is
        port (
            clk : in std_logic;
            address : in unsigned(6 downto 0);
            data : out unsigned(15 downto 0)
        );
    end component rom;

    component control_unit is
        port(
            clk     : in std_logic;
            rst     : in std_logic;
            opcode  : in unsigned(3 downto 0);
            state   : out std_logic;    -- for debugging
            pc_wr   : out std_logic;
            ir_wr   : out std_logic;
            reg_bank_wr : out std_logic;
            jump_sel: out std_logic;
            nop_sel : out std_logic
        );
    end component control_unit;

    component instruction_register is
        port( clk      : in std_logic;
              rst      : in std_logic;
              wr_en    : in std_logic;
              data_in  : in unsigned(15 downto 0);
              data_out : out unsigned(15 downto 0)
        );
     end component instruction_register;

    component ula is 
        port(    data1_in, data2_in : in unsigned (15 downto 0);      
         sel_op             : in unsigned(1 downto 0);        
         data3_out          : out unsigned (15 downto 0);     
         carry              : out std_logic;
         overflow           : out std_logic);
    end component;

    component register_bank is
        port(    clk, rst, wr_en: in  std_logic; 
         data_in        : in  unsigned(15 downto 0);
         selin_reg      : in  unsigned(2 downto 0);
         selout_reg     : in  unsigned(2 downto 0);
         data_out       : out unsigned(15 downto 0));
    end component;

    component acumulator is
        port( clk      : in std_logic;
      rst      : in std_logic;
      wr_en    : in std_logic;
      acumulator_in  : in unsigned(15 downto 0);
      acumulator_out : out unsigned(15 downto 0));
    end component;

    component mux is 
        port(    control_signal: in std_logic; 
         a, b: in unsigned (15 downto 0);
         c: out unsigned (15 downto 0));
    end component;
    ---------------------------------------------

    -- signals.

    -- program counter signals
    signal pc_adress_out_s: unsigned(6 downto 0);
    signal pc_increment_s: unsigned(6 downto 0);

    -- control unit signals
    signal pc_wr_s: std_logic;
    signal ir_wr_s: std_logic;
    signal reg_bank_wr_s: std_logic
    signal jump_sel_s: std_logic;
    signal nop_sel_s: std_logic;

    -- instruction partition signals (missing a lot of signals here)
    signal rom_data_out_s: unsigned(15 downto 0);
    signal opcode_s: unsigned(3 downto 0);
    signal instruction_address_s: unsigned(6 downto 0);

    -- instruction register signals:
    signal ir_out_s: unsigned (15 downto 0);

    -- mux between constant and register bank signals
    signal mux_cte_regs_input_a_s: unsigned(15 downto 0);
    signal mux_cte_regs_input_b_s: unsigned(15 downto 0);
    signal mux_cte_regs_output_s: unsigned(15 downto 0);

    -- mux between constant and ula output signals
    signal mux_cte_ula_input_a_s: unsigned(15 downto 0);
    signal mux_cte_ula_input_b_s: unsigned(15 downto 0);
    signal mux_cte_ula_output_s: unsigned(15 downto 0);
    
    -- register bank signals
    signal selin_reg_s: unsigned(2 downto 0);
    signal selout_reg_s: unsigned(2 downto 0);

    -- acumulator signals
    signal acc_in_s: unsigned(15 downto 0);
    signal acc_rst_s: std_logic;
    signal acc_wr_en_s: std_logic;
    signal acc_out_s: unsigned(15 downto 0);

    -- ula signals
    signal ula_sel_op_s: unsigned(1 downto 0);
    signal ula_carry_s: std_logic;
    signal ula_overflow_s: std_logic;

    -- component instantiation
    cu : control_unit
        port map (
            clk => clk,
            rst => rst,
            opcode => opcode_s,
            state => state_out,             -- state machine is inside control unit
            pc_wr => pc_wr_s,
            ir_wr => ir_wr_s,
            reg_bank_wr => reg_bank_wr_s,
            jump_sel => jump_sel_s,                
            nop_sel => nop_sel_s
        );

    pc : program_counter
        port map (
            clk => clk,
            wr_en => pc_wr_s,               -- controled by control unit
            rst => rst,
            increment => pc_increment_s,    -- controled on this file logic
            data_out => pc_adress_out_s
        );

    mem_rom : rom
        port map (
            clk => clk,
            address => pc_adress_out_s,
            data => rom_data_out_s
        );

    i_reg : instruction_register 
        port map (
            clk => clk,
            rst => rst,
            wr_en => ir_wr_s,               -- controled by control unit
            data_in  => rom_data_out_s,
            data_out => ir_out_s,
        );
    
     -- Mux para selecionar entre constante e saida do banco de regs.
    p_mux_cte_regs : mux 
        port map (
            a => mux_cte_regs_input_a_s,    -- cte 
            b => mux_cte_regs_input_b_s,    -- register bank output
            control_signal => ,             -- selected by instruction
            c => mux_cte_regs_output_s
        );

    -- Mux para selecionar entre constante e saida da ULA
    p_mux_cte_ula: mux 
        port map (
            a => mux_cte_ula_input_a_s,    -- cte 
            b => mux_cte_ula_input_b_s,    -- ula output
            control_signal => ,            -- selected by instruction
            c => mux_cte_ula_output_s
        );
 
    p_regbank: register_bank 
        port map (
            clk => clk, 
            rst => rst, 
            wr_en => reg_bank_wr_s,             -- controlled by control unit (not implemented yet)
            data_in => acc_out_s,               -- acc output 
            selin_reg => selin_reg_s,           -- selected by instruction
            selout_reg => selout_reg_s,         -- selected by instruction    
            data_out => mux_cte_regs_input_b_s             
        );
    
    -- Tem como entrada um mux que seleciona entre a constante e a saida da ULA
    p_acumulator: acumulator 
        port map (
            clk => clk,
            rst => acc_rst_s,                       -- controled by control unit (not implemented yet)
            wr_en => acc_wr_en_s,                   -- controled by control unit (not implemented yet)
            acumulator_in => mux_cte_ula_output_s,     
            acumulator_out => acc_out_s
        );

    -- Uma das entradas da ULA é o acumulador, a outra um mux que seleciona entre o bando de regs. e a constante
    p_ula: ula 
        port map (
            data1_in => mux_cte_regs_output_s,
            data2_in => acc_out_s, 
            sel_op => ula_sel_op_s                  -- selected by instruction
            data3_out => mux_cte_ula_input_b_s,                      
            carry => ula_carry_s,                   -- no use for now (maybe)
            overflow => ula_overflow_s              -- no use for now (maybe)
        );
    
    -- Logic

    -- rom instrucion partition
    opcode_s <= ir_out_s(15 downto 12);
    instruction_address_s <= ir_out_s(6 downto 0);

    -- pc increment calculation
    pc_increment_s <=   "0000001" when (jump_sel_s = '0' or nop_sel_s = '1') else               --logic on this line will change when more instructions are added (maybe)
                        (instruction_address_s - pc_adress_out_s) when jump_sel_s = '1' else    --absolute increment
                        "0000001";                                                              --default increment (may change later on)

end architecture tmp_a;
