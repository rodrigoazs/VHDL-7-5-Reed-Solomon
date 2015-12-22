library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity BinaryAdderSubtractor is
	port( a,b: in std_logic_vector(3 downto 0);
	fnc: in std_logic;
	s_or_d: out std_logic_vector(3 downto 0)
	);
end BinaryAdderSubtractor;

architecture Behavioral of BinaryAdderSubtractor is
component fa is
	Port (	a : in	std_logic;
		b : in	std_logic;
		c : in	std_logic;
		sum1: out std_logic;
		sum0: out std_logic);
end component;

	signal c: std_logic_vector(3 downto 0);
	signal pb: std_logic_vector(3 downto 0);

begin

pb(0) <= b(0) xor fnc;
pb(1) <= b(1) xor fnc;
pb(2) <= b(2) xor fnc;
pb(3) <= b(3) xor fnc;

fa0: fa port map(a(0), pb(0), fnc, c(0), s_or_d(0));
fa1: fa port map(a(1), pb(1), c(0), c(1), s_or_d(1));
fa2: fa port map(a(2), pb(2), c(1), c(2), s_or_d(2));
fa3: fa port map(a(3), pb(3), c(2), c(3), s_or_d(3));

end Behavioral;
