library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity ErrorGenerator is
    Port ( Clock : in  std_logic;
	Qout: out std_logic_vector(2 downto 0));
end ErrorGenerator;

architecture Behavioral of ErrorGenerator is

component flipflop is
	 Port (	D: in std_logic_vector(2 downto 0); 
		Clock: in std_logic;
		Reset: in std_logic;
		Q: out std_logic_vector(2 downto 0)); 
end component; 

signal SymbolRandom: std_logic_vector(2 downto 0);
signal ErrorStop: std_logic;
signal Result: std_logic_vector(2 downto 0);

signal Dsa0 : std_logic_vector(2 downto 0);
signal Dsa1 : std_logic_vector(2 downto 0);
signal Dsa2 : std_logic_vector(2 downto 0);
signal Dsa3 : std_logic_vector(2 downto 0);
signal Dsa4 : std_logic_vector(2 downto 0);
signal Dsa5 : std_logic_vector(2 downto 0);
signal Dsa6 : std_logic_vector(2 downto 0);

signal Qsa0 : std_logic_vector(2 downto 0);
signal Qsa1 : std_logic_vector(2 downto 0);
signal Qsa2 : std_logic_vector(2 downto 0);
signal Qsa3 : std_logic_vector(2 downto 0);
signal Qsa4 : std_logic_vector(2 downto 0);
signal Qsa5 : std_logic_vector(2 downto 0);
signal Qsa6 : std_logic_vector(2 downto 0);

signal counter_rnd: std_logic_vector(2 downto 0) := "000";

begin

ffsymbola0 : flipflop Port map (Dsa0,Clock,'0',Qsa0);
ffsymbola1 : flipflop Port map (Dsa1,Clock,'0',Qsa1);
ffsymbola2 : flipflop Port map (Dsa2,Clock,'0',Qsa2);
ffsymbola3 : flipflop Port map (Dsa3,Clock,'0',Qsa3);
ffsymbola4 : flipflop Port map (Dsa4,Clock,'0',Qsa4);
ffsymbola5 : flipflop Port map (Dsa5,Clock,'0',Qsa5);
ffsymbola6 : flipflop Port map (Dsa6,Clock,'0',Qsa6);
	
Result(0) <= Qsa2(1) xor Qsa4(1) xor Qsa3(1) xor Qsa2(2) xor Qsa0(0) xor Qsa2(0) xor Qsa1(2) xor Qsa5(0);
Result(1) <= Qsa4(0) xor Qsa1(0) xor Qsa5(0) xor Qsa2(0) xor Qsa2(2) xor Qsa1(2) xor Qsa0(2);
Result(2) <= Qsa2(2) xor Qsa0(2) xor Qsa2(2) xor Qsa4(1) xor Qsa1(1) xor Qsa5(1);
SymbolRandom(0) <= Qsa3(0) xor Qsa5(2) xor Qsa1(1) xor Qsa6(1) xor Qsa3(2) xor Qsa1(2) xor Qsa5(2);
SymbolRandom(1) <= Qsa5(1) xor Qsa1(1) xor Qsa2(1) xor Qsa4(0) xor Qsa0(2) xor Qsa6(0);
SymbolRandom(2) <= Qsa1(2) xor Qsa0(2) xor Qsa0(0) xor Qsa3(2) xor Qsa3(1);
		
Dsa0 <= Qsa1;
Dsa1 <= Qsa2;
Dsa2 <= Qsa3;
Dsa3 <= Qsa4;
Dsa4 <= Qsa5;
Dsa5 <= Qsa6;
Dsa6 <= Result;
		
process(Clock, Result)
begin
	if (Clock'event and Clock='1') then
		counter_rnd <= counter_rnd + 1;
		if ((Result(0) xor Result(2)
		xor Result(1))='1' and ErrorStop/='1')
		then
			Qout(0) <= SymbolRandom(0);
			Qout(1) <= SymbolRandom(1);
			Qout(2) <= SymbolRandom(2);
			ErrorStop <= '1';
		else
			Qout <= "000";
		end if;
		if(counter_rnd = "111") then
			counter_rnd <= "001";
			ErrorStop <= '0';
		end if;
	end if;
end process;

end Behavioral;
