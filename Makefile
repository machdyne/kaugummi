blinky_kaugummi:
	mkdir -p output
	yosys -q -p "synth_ecp5 -top blinky -json output/blinky_kaugummi.json" rtl/blinky_kaugummi.v
	nextpnr-ecp5 --12k --package CABGA256 --lpf kaugummi_v2.lpf --json output/blinky_kaugummi.json --textcfg output/kaugummi_blinky_out.config
	ecppack -v --compress --freq 2.4 output/kaugummi_blinky_out.config --bit output/kaugummi.bit

prog:
	openFPGALoader -c usb-blaster output/kaugummi.bit
