build:  
	ghdl -a KSA/src/*.vhd
	ghdl -a KSA/Testbenches/*.vhd

run16:  
	ghdl -e ksa_16_tb
	ghdl -r ksa_16_tb --vcd=ksa_16_tb.vcd
	gtkwave ksa_16_tb.vcd
	gtkwave -v -S gw.tcl

run32:	
	ghdl -e ksa_32_tb
	ghdl -r ksa_32_tb --vcd=ksa_32_tb.vcd
	gtkwave ksa_32_tb.vcd
	gtkwave -v -S gw.tcl

clean: 
	rm -rf *.cf *.o *.ghw *.vcd