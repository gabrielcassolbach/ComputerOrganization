t = processor

compile:
	@mkdir -p waves

	ghdl -a --std=08 *.vhd 
	ghdl -a --std=08 ula/*.vhd
	ghdl -a --std=08 register_bank/*.vhd
	ghdl -a --std=08 acumulador/*.vhd

	ghdl -a --std=08 test/$(t)_tb.vhd 
	ghdl -e --std=08 $(t)_tb
	ghdl -r --std=08 $(t)_tb --wave=waves/$(t)_tb.ghw --stop-time=1ms

	rm *.cf
	
	gtkwave waves/$(t)_tb.ghw