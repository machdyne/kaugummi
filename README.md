# Kaugummi Computer

Kaugummi is an FPGA computer designed by Lone Dynamics Corporation.

![Kaugummi Computer](https://github.com/machdyne/kaugummi/blob/5c1a97a798fe1a9e097b1bd264d63cd1725bd8fb/kaugummi.png)

This repo will contain schematics, PCB layouts, pinouts, a 3D-printable case, example gateware and documentation.

Find more information on the [Kaugummi product page](https://machdyne.com/product/kaugummi-computer/).

## Programming Kaugummi

Kaugummi has a JTAG interface and ships with a [DFU bootloader](https://github.com/machdyne/tinydfu-bootloader) that allows the flash memory to be programmed over the USB-C port.

### DFU

The DFU bootloader is available for 5 seconds after power-on, issuing a DFU command during this period will stop the boot process until the DFU device is detached. If no command is received the boot process will continue and the user gateware will be loaded.

Install [dfu-util](http://dfu-util.sourceforge.net) (Debian/Ubuntu):

```
$ sudo apt install dfu-util
```

Update the user gateware on the flash memory:

```
$ sudo dfu-util -a 0 -D image.bit
```

Detach the DFU device and continue the boot process:

```
$ sudo dfu-util -a 0 -e
```

It is possible to update the bootloader itself using DFU but you shouldn't attempt this unless you have a JTAG programmer (or another method to program the MMOD) available, in case you need to restore the bootloader.

### JTAG

These examples assume you're using a "USB Blaster" JTAG cable, see the header pinout below. You will need to have [openFPGALoader](https://github.com/trabucayre/openFPGALoader) installed.

Program the configuration SRAM:

```
openFPGALoader -c usb-blaster image.bit
```

Program the flash:

```
openFPGALoader -f -c usb-blaster images/bootloader/tinydfu_kaugummi.bit
```

## Blinky 

Building the blinky example requires [Yosys](https://github.com/YosysHQ/yosys), [nextpnr-ecp5](https://github.com/YosysHQ/nextpnr) and [Project Trellis](https://github.com/YosysHQ/prjtrellis).

Assuming they are installed, you can simply type `make` to build the gateware, which will be written to output/blinky.bin. You can then use [openFPGALoader](https://github.com/trabucayre/openFPGALoader) or dfu-util to write the gateware to the device.

## Linux

See the [Kakao Linux](https://github.com/machdyne/kakao) repo for the latest instructions.

## Pinouts

### Dock/HID 2.54mm Header

| Pin | Signal | Notes |
| --- | ------ | ----- |
| 1 | PWR5V0 | 5V Input |
| 2 | GND | |
| 3 | PWR5V0 | 5V Output (VBUS) |
| 4 | USB1\_DP | USB Host D+ |
| 5 | USB1\_DN | USB Host D- |
| 6 | GND | |

### RGB LCD FFC Connector

| Pin | Signal | Notes |
| --- | ------ | ----- |
| 1 | VLED\_N | Backlight Cathode |
| 2 | VLED\_P | Backlight Anode |
| 3 | GND | |
| 4 | PWR3V3 | |
| 5 | LCD\_R0 | Red |
| 6 | LCD\_R1 | |
| 7 | LCD\_R2 | |
| 8 | LCD\_R3 | |
| 9 | LCD\_R4 | |
| 10 | LCD\_R5 | |
| 11 | LCD\_R6 | |
| 12 | LCD\_R7 | |
| 13 | LCD\_G0 | Green |
| 14 | LCD\_G1 | |
| 15 | LCD\_G2 | |
| 16 | LCD\_G3 | |
| 17 | LCD\_G4 | |
| 18 | LCD\_G5 | |
| 19 | LCD\_G6 | |
| 20 | LCD\_G7 | |
| 21 | LCD\_B0 | Blue |
| 22 | LCD\_B1 | |
| 23 | LCD\_B2 | |
| 24 | LCD\_B3 | |
| 25 | LCD\_B4 | |
| 26 | LCD\_B5 | |
| 27 | LCD\_B6 | |
| 28 | LCD\_B7 | |
| 29 | GND | |
| 30 | LCD\_CLK | Clock |
| 31 | LCD\_DISP | Display On |
| 32 | LCD\_HS | Horizontal Sync |
| 33 | LCD\_VS | Vertical Sync |
| 34 | LCD\_DE | Data Enable |
| 35 | NC | |
| 36 | GND | |
| 37 | LCD\_XR | Touch X-right |
| 38 | LCD\_YD | Touch Y-down |
| 39 | LCD\_XL | Touch X-left |
| 40 | LCD\_YU | Touch Y-up |

### JTAG Header

The 3.3V JTAG header can be used to program the FPGA SRAM as well as the flash memory. It can also be used to provide power (5V) to the board.

```
2 4 5
1 3 6
```

| Pin | Signal |
| --- | ------ |
| 1 | TCK |
| 2 | TDI |
| 3 | TDO |
| 4 | TMS |
| 5 | 5V0 |
| 6 | GND |

### UART Header

```
2
1
```

| Pin | Signal |
| --- | ------ |
| 2 | RX (FPGA receive) |
| 1 | TX (FPGA transmit) |

## Board Revisions

| Revision | Notes |
| -------- | ----- |
| V2 | Initial production version |

## License

The contents of this repo are released under the [Lone Dynamics Open License](LICENSE.md).

Note: You can use these designs for commercial purposes but we ask that instead of producing exact clones, that you either replace our trademarks and logos with your own or add your own next to ours.
