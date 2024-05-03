t = control_unit

compile:
	@mkdir -p waves
 
	ghdl -a --std=08 ula/*.vhd
	ghdl -a --std=08 register_bank/*.vhd
	ghdl -a --std=08 acumulator/*.vhd
	ghdl -a --std=08 rom/*.vhd
	ghdl -a --std=08 state_machine/*.vhd
	ghdl -a --std=08 program_counter/*.vhd
	ghdl -a --std=08 pc_rom_test/*.vhd
	ghdl -a --std=08 reg7bits/*.vhd
	ghdl -a --std=08 control_unit/*.vhd

	ghdl -a --std=08 $(t)/$(t)_tb.vhd 
	ghdl -e --std=08 $(t)_tb
	ghdl -r --std=08 $(t)_tb --wave=waves/$(t)_tb.ghw --stop-time=1ms

	rm *.cf
	
	gtkwave waves/$(t)_tb.ghw