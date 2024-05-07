library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test is
    port (
        clk : in std_logic;
        rst : in std_logic;
        cu_state : out std_logic;    -- for debugging
        rom_data_out : out unsigned(15 downto 0)
    );
end entity test;

architecture test_a of test is
    -- component declarations
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
            jump_sel: out std_logic;
            nop_sel : out std_logic
        );
    end component control_unit;
    
    -- signal declarations
    
    -- program counter signals
    signal pc_adress_out_s: unsigned(6 downto 0);
    signal pc_increment_s: unsigned(6 downto 0);
    -- control unit signals
    signal pc_wr_s: std_logic;
    signal jump_sel_s: std_logic;
    signal nop_sel_s: std_logic;
    -- instruction partition signals (missing a lot of signals here)
    signal rom_data_out_s: unsigned(15 downto 0);
    signal opcode_s: unsigned(3 downto 0);
    signal instruction_address_s: unsigned(6 downto 0);
    
begin
    -- component instantiation
    cu : control_unit
        port map (
            clk => clk,
            rst => rst,
            opcode => opcode_s,
            state => cu_state,
            pc_wr => pc_wr_s,
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

    -- rom instrucion partition
    opcode_s <= rom_data_out_s(15 downto 12);
    instruction_address_s <= rom_data_out_s(6 downto 0);

    -- pc increment calculation
    pc_increment_s <=   "0000001" when (jump_sel_s = '0' or nop_sel_s = '1') else               --logic on this line will change when more instructions are added
                        (instruction_address_s - pc_adress_out_s) when jump_sel_s = '1' else
                        "0000001";                                                              --default increment (may change later on)

    rom_data_out <= rom_data_out_s;
    
end architecture test_a;
