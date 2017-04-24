build: 
	ghdl -a FPU/src/fp_pkg.vhd
	ghdl -a KSA/src/*.vhd
	ghdl -a FPU/src/fp_pkg.vhd
	ghdl -a KSA/testbenches/*.vhd
	ghdl -a FPU/src/fp_pkg.vhd
	ghdl -a FPU/src/*.vhd
	ghdl -a FPU/src/fp_pkg.vhd
	ghdl -a FPU/testbenches/*.vhd
	ghdl -a FPU/src/fp_pkg.vhd
run16:
	ghdl -a KSA/src/ksa_16.vhd
	ghdl -e ksa_16_tb
	ghdl -r ksa_16_tb --vcd=ksa_16_tb.vcd
	gtkwave ksa_16_tb.vcd
	gtkwave -v -S gw.tcl

run32:	
	ghdl -a KSA/src/ksa_32.vhd
	ghdl -e ksa_32_tb
	ghdl -r ksa_32_tb --vcd=ksa_32_tb.vcd
	gtkwave ksa_32_tb.vcd
	gtkwave -v -S gw.tcl

runadd:	
	ghdl -a FPU/src/fp_adder.vhd
	ghdl -e fp_adder_tb
	ghdl -r fp_adder_tb --vcd=fp_adder_tb.vcd
	gtkwave fp_adder_tb.vcd
	gtkwave -v -S gw.tcl

runsub:	
	ghdl -a FPU/src/fp_subtractor.vhd
	ghdl -e fp_subtractor_tb
	ghdl -r fp_subtractor_tb --vcd=fp_subtractor_tb.vcd
	gtkwave fp_subtractor_tb.vcd
	gtkwave -v -S gw.tcl

runcomp:
	ghdl -a FPU/src/fp_compare.vhd	
	ghdl -a FPU/testbenches/fp_compare_tb.vhd
	ghdl -e fp_compare_tb
	ghdl -r fp_compare_tb --vcd=fp_compare_tb.vcd
	gtkwave fp_compare_tb.vcd
	gtkwave -v -S gw.tcl

clean: 
	rm -rf *.cf *.o *.ghw *.vcd