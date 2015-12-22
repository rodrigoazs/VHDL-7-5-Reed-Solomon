library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity Mux6x3 is
	Port (	a : in std_logic_vector(2 downto 0) ;
		b : in std_logic_vector(2 downto 0) ;
		s : in std_logic ;
		f : out std_logic_vector(2 downto 0));
end Mux6x3 ;

architecture Behavior OF Mux6x3 is

begin

	with s select
		f <= b when '0',
			a when others;
			
end Behavior ;
