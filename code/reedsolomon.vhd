library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity ReedSolomon is

end ReedSolomon;

architecture Behavioral of ReedSolomon is
component ReedSolomonEncoder is
    Port ( Clock : in std_logic;
	Count7 : in std_logic;
	Qs0 : in std_logic_vector(2 downto 0);
	Qp : out std_logic_vector(2 downto 0));
end component;

component ReedSolomonDecoder is
    Port ( Clock : in  std_logic;
	Count7 : in  std_logic;
	Qs0: in std_logic_vector(2 downto 0);
	Dsyn1: out std_logic_vector(2 downto 0);
	Dsyn2: out std_logic_vector(2 downto 0));
end component;

component counter is

   Port( Clock: in std_logic;
	 Count5: out std_logic;
	 Count7: out std_logic);

end component;

component mux6 is
	Port (y1: in std_logic_vector(2 downto 0);
		y0: in std_logic_vector(2 downto 0);
		s: in std_logic;
		f: out std_logic_vector(2 downto 0));
end component ;

component flipflop is
	 Port (	D: in std_logic_vector(2 downto 0);
		Clock: in std_logic;
		Reset: in std_logic;
		Q: out std_logic_vector(2 downto 0));
end component ;

component ErrorGenerator is
    Port ( Clock : in  std_logic;
	Qout: out std_logic_vector(2 downto 0));
end component;

component ErrorGuessing is
    Port ( Syndrome: in std_logic_vector(5 downto 0);
           Error : out  std_logic_vector(20 downto 0));
end component;

component read_file is
	Port (Clock: in std_logic;
		Qout: out std_logic_vector(2 downto 0));

end component;

component write_file is
	Port (Clock: in std_logic;
	Message: in std_logic_vector(14 downto 0));

end component;

component write_error is
	Port (Clock: in std_logic;
	Message: in std_logic_vector(14 downto 0));

end component;

signal Qp: std_logic_vector(2 downto 0);
signal Count5: std_logic;
signal Count7: std_logic;
signal out_mux1: std_logic_vector(2 downto 0);
signal ErrorGenerated: std_logic_vector(2 downto 0);
signal out2: std_logic_vector(2 downto 0);
signal unusual: std_logic;

signal Qs0 : std_logic_vector(2 downto 0);
signal Db0 : std_logic_vector(2 downto 0);
signal Db1 : std_logic_vector(2 downto 0);
signal Db2 : std_logic_vector(2 downto 0);
signal Db3 : std_logic_vector(2 downto 0);
signal Db4 : std_logic_vector(2 downto 0);
signal Db5 : std_logic_vector(2 downto 0);
signal Db6 : std_logic_vector(2 downto 0);
signal Qb0 : std_logic_vector(2 downto 0);
signal Qb1 : std_logic_vector(2 downto 0);
signal Qb2 : std_logic_vector(2 downto 0);
signal Qb3 : std_logic_vector(2 downto 0);
signal Qb4 : std_logic_vector(2 downto 0);
signal Qb5 : std_logic_vector(2 downto 0);
signal Qb6 : std_logic_vector(2 downto 0);
signal Din : std_logic_vector(2 downto 0);
signal Syn1 : std_logic_vector(2 downto 0);
signal Syn2 : std_logic_vector(2 downto 0);
signal Syndrome : std_logic_vector(5 downto 0);
signal Error : std_logic_vector(20 downto 0);
signal Message: std_logic_vector(14 downto 0);
signal MessageError: std_logic_vector(14 downto 0);

signal Clock: std_logic;

begin

readdata: read_file Port map (Clock, Qs0);

muxCount: mux6 Port map (Qp, Qs0, Count5, Din);

RDE: ReedSolomonEncoder Port map (Clock, Count7, Din, Qp);

muxa: mux6 Port map (Qp, Din, Count5, out_mux1);

RndGen: ErrorGenerator Port map (Clock, ErrorGenerated);

out2(0) <= out_mux1(0) xor ErrorGenerated(0);
out2(1) <= out_mux1(1) xor ErrorGenerated(1);
out2(2) <= out_mux1(2) xor ErrorGenerated(2);

Db6 <= out2;

ffbuffer0 : flipflop Port map (Db0,Clock,'0',Qb0);
ffbuffer1 : flipflop Port map (Db1,Clock,'0',Qb1);
ffbuffer2 : flipflop Port map (Db2,Clock,'0',Qb2);
ffbuffer3 : flipflop Port map (Db3,Clock,'0',Qb3);
ffbuffer4 : flipflop Port map (Db4,Clock,'0',Qb4);
ffbuffer5 : flipflop Port map (Db5,Clock,'0',Qb5);
ffbuffer6 : flipflop Port map (Db6,Clock,'0',Qb6);

RDD: ReedSolomonDecoder Port map (Clock, Count7, out2,
 Syn1, Syn2);

Syndrome(0) <= Syn2(0);
Syndrome(1) <= Syn2(1);
Syndrome(2) <= Syn2(2);
Syndrome(3) <= Syn1(0);
Syndrome(4) <= Syn1(1);
Syndrome(5) <= Syn1(2);

ErrorGuess: ErrorGuessing Port map (Syndrome, Error);

MessageError(0) <= Db0(0);
MessageError(1) <= Db0(1);
MessageError(2) <= Db0(2);
MessageError(3) <= Db1(0);
MessageError(4) <= Db1(1);
MessageError(5) <= Db1(2);
MessageError(6) <= Db2(0);
MessageError(7) <= Db2(1);
MessageError(8) <= Db2(2);
MessageError(9) <= Db3(0);
MessageError(10) <= Db3(1);
MessageError(11) <= Db3(2);
MessageError(12) <= Db4(0);
MessageError(13) <= Db4(1);
MessageError(14) <= Db4(2);

Message(0) <= Db0(0) xor Error(0);
Message(1) <= Db0(1) xor Error(1);
Message(2) <= Db0(2) xor Error(2);
Message(3) <= Db1(0) xor Error(3);
Message(4) <= Db1(1) xor Error(4);
Message(5) <= Db1(2) xor Error(5);
Message(6) <= Db2(0) xor Error(6);
Message(7) <= Db2(1) xor Error(7);
Message(8) <= Db2(2) xor Error(8);
Message(9) <= Db3(0) xor Error(9);
Message(10) <= Db3(1) xor Error(10);
Message(11) <= Db3(2) xor Error(11);
Message(12) <= Db4(0) xor Error(12);
Message(13) <= Db4(1) xor Error(13);
Message(14) <= Db4(2) xor Error(14);

Db0 <= Qb1;
Db1 <= Qb2;
Db2 <= Qb3;
Db3 <= Qb4;
Db4 <= Qb5;
Db5 <= Qb6;

count1: counter Port map (Clock, Count5, Count7);

writedata: write_file Port map (Clock, Message);
writeerror: write_error Port map (Clock, MessageError);

end Behavioral;
