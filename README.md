# 7-5-Reed-Solomon
Implementation of (7,5) Reed-Solomon encoding and decoding in VHDL

A Reed-Solomon (RS) Code is a cyclic error correction and detection code that uses symbol
patterns instead of the standard bit patterns in order to transmit and receive messages.
Each symbol is constituted of m different bits and the correlation between bits and symbols
is done using the theory of Finite Fields.

For more information about it please read the <a href="https://en.wikipedia.org/wiki/Reed%E2%80%93Solomon_error_correction">Reed-Solomon error correction article from Wikipedia</a>

This code consists of the implementation of the Reed-Solomon Encoder and Decoder and also a simulation of a channel. The whole system is represented by the following schematics:

<img src="http://i.imgur.com/FMSjazQ.png">

As two symbols are going to be multiplied they enter the system described in the next figure.
After entering the system each symbol should pass through a Symbol Power Encoder. This
encoder will map each symbol power into its equivalent decimal. Note that this mapping
process is much smaller then the one required to map all the multiplication possibilities
between 3-bit symbols. While this mapping only maps 7 different patterns a full multiplier
encoder using a table would have to map 64 different patterns.

<img src="http://i.imgur.com/YEruKV8.png">

This component is essencial to be used in the Reed-Solomon Encoder and Decoder. As you can see in the following figure, the Symbol Multiplier is represented by the "X" component.

<img src="http://i.imgur.com/s6aIIky.png">

In order to test the system, the simulation of the channel was done using a pseudo random generator that will generate really long sequences of random numbers until it starts repeating. This was done using a Linear Feedback Shift Register (LFSR) which is a cascade of Flip Flops with feedback addition of random outputs that is able to generate a random output in each clock cycle.

<img src="http://i.imgur.com/xVUMgaB.png">

`read.txt` - Contains the binary data to be sent through the channel. Blocks of 15 bits per line.<br>
`write_error.txt` - Contains the binary data after getting artificial errors in the channel.<br>
`write_file.txt` - Contains the binary data after error correction.<br>

Using ISim (Xilinx):
```
isim force add {/reedsolomon/RndGen/dsa0} 010 -radix bin -cancel 1 ps<br>
isim force add {/reedsolomon/RndGen/dsa1} 110 -radix bin -cancel 1 ps<br> 
isim force add {/reedsolomon/RndGen/dsa2} 001 -radix bin -cancel 1 ps<br> 
isim force add {/reedsolomon/RndGen/dsa3} 110 -radix bin -cancel 1 ps<br> 
isim force add {/reedsolomon/RndGen/dsa4} 101 -radix bin -cancel 1 ps<br> 
isim force add {/reedsolomon/RndGen/dsa5} 110 -radix bin -cancel 1 ps<br> 
isim force add {/reedsolomon/RndGen/dsa6} 100 -radix bin -cancel 1 ps<br>
isim force add {/reedsolomon/RDE/d1} 000 -radix bin -cancel 1 ps<br>
isim force add {/reedsolomon/RDE/d2} 000 -radix bin -cancel 1 ps<br>
isim force add {/reedsolomon/RDD/d1} 000 -radix bin -cancel 1 ps<br>
isim force add {/reedsolomon/RDD/d2} 000 -radix bin -cancel 1 ps<br>
 
isim force add {/reedsolomon/clock} 0 -radix bin -value 1 -radix bin -time 1 ps -repeat 2 ps -cancel 574 ps
```
The signals dsa0 to dsa6 are the seed for the Pseudo Random Number Generator block, you can start these with any random numbers of 3 bits.

574 ps is the clock, try to use something like (1+number_of_bits_in_the_message/15)*14

Please, read the <a href="https://github.com/rodrigoazs/-7-5-Reed-Solomon/raw/master/Report.pdf">whole project</a> to get more information about.
