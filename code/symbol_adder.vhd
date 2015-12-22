library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity SymbolAdder is
	 Port (	a : in std_logic_vector(2 downto 0); 
		b : in std_logic_vector(2 downto 0);
		c : out std_logic_vector(2 downto 0)); 
end SymbolAdder;

architecture Behavioral of SymbolAdder is

begin
	c(0) <= a(0) xor b(0);
	c(1) <= a(1) xor b(1);
	c(2) <= a(2) xor b(2);

end Behavioral;
