# Floating Point Arithmetic Unit

Decimal Floating Point arithmetic implemented in vhdl based on kog-stone adder, a parallel prefix form carry look-ahead adder. It supports operations on IEEE 794 single precision binary numbers.

## Getting Started On MAC OS



### Prerequisites

Xcode (https://developer.apple.com/xcode/)

```
https://developer.apple.com/download/
```
Xcode command line tools 

```BASH
$xcode-select --install
```

GHDL (http://ghdl.free.fr/)

```
https://github.com/tgingold/ghdl/releases/tag/v0.33
```

Macports (https://www.macports.org/)

```
https://www.macports.org/install.php
```

gtkwave (http://gtkwave.sourceforge.net/)

```BASH
$sudo port install gtkwave
```

X11 

```
https://www.xquartz.org/
```


## Building on MAC OS

### Kog-Stone Adder:

To build the 16-bit and 32-bit adders:

```
$make build
```

## Running the testbenches

### Adders

To run the 16-bit adder testbench:

```
$make run16
```
A gtkwave window similar to the following should appear, at the top left you can find the components, under it you find the signals, and to the right you find the graph.


<img src="https://image.ibb.co/czjPiv/Screen_Shot_2017_04_03_at_12_51_54_AM.png" width="800">

To add the signals to the graph, select the first signal, hold shift and select the last signal, then press on insert. You should see the following.


<img src="https://image.ibb.co/hbkmwF/Screen_Shot_2017_04_03_at_12_53_54_AM.png" width="800">


To make an std_logic_vector signal appear in decimal instead of hexadecimals, select the signal, right-click then Data Format/Decimal as shown below


<img src="https://image.ibb.co/gNrRwF/Screen_Shot_2017_04_03_at_12_54_14_AM.png" width="800">


the same can be done for the 32-bit adder using:

```
$make run32
```

## Authors

* **Mohamad-Ali Itani**

## Acknowledgments

* adapted KSA adder from https://github.com/LarbiBekka34/miniproject-vhdl
