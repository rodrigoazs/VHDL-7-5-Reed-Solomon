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

Please, read the <a href="https://github.com/rodrigoazs/-7-5-Reed-Solomon/raw/master/Report.pdf">whole project</a> to get more information about.
