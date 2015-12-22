library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity ThreeBitFlipFlop is 
	 Port (	D : in std_logic_vector(2 downto 0); 
		Clock : in std_logic;
		Q : out std_logic_vector(2 downto 0)); 
end ThreeBitFlipFlop ; 

architecture Behavior OF ThreeBitFlipFlop is    
begin
	process
	begin
		wait until Clock'event and Clock = '1' ;
		Q <= D ; 
	end process ; 
end Behavior ; 
