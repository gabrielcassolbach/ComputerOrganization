library ieee;
use ieee.std_logic_1164.all;   
use ieee.numeric_std.all;

entity tmp is
    port (
        clk           : in std_logic;
        rst           : in std_logic;
        state_out         : out unsigned (1 downto 0);   
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

    -- component instantiation
    cu : control_unit
        port map (
            clk => clk,
            rst => rst,
            opcode => opcode_s,
            state => state_out,
            pc_wr => pc_wr_s,
            ir_wr => ir_wr_s,
            reg_bank_wr => reg_bank_wr_s,
            jump_sel => jump_sel_s,                
            nop_sel => nop_sel_s
        );

    pc : program_counter
        port map (
            clk => clk,
            wr_en => pc_wr_s,
            rst => rst,
            increment => pc_increment_s,
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
            wr_en => ir_wr_s,
            data_in  => rom_data_out_s,
            data_out => ir_out_s,
        );
    
     -- Mux para selecionar entre constante e saida do banco de regs.
    p_mux_cte_regs : mux 
        port map (
            a => ,
            b => ,
            control_signal => , 
            c => 
        );

    -- Mux para selecionar entre constante e saida da ULA
    p_mux_cte_ula: mux 
        port map (
            a => , 
            b => ,
            control_signal => , 
            c => 
        );
 
    p_regbank: register_bank 
        port map (
            clk => clk, 
            rst => rst, 
            wr_en => reg_bank_wr_s, 
            data_in => ,            -- Saida do acc 
            selin_reg => ,
            selout_reg => , 
            data_out => 
        );
    
    -- Tem como entrada um mux que seleciona entre a constante e a saida da ULA
    p_acumulator: acumulator 
        port map (
            clk => clk,
            rst => ,
            wr_en => ,
            acumulator_in => ,
            acumulator_out => 
        );

    -- Uma das entradas da ULA é o acumulador, a outra um mux que seleciona entre o bando de regs. e a constante
    p_ula: ula 
        port map (
            data1_in => ,
            data2_in => ,  --Uma entrada da ULA sempre é o acumulador 
            sel_op => ,
            data3_out => ,
            carry => , 
            overflow => 
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
