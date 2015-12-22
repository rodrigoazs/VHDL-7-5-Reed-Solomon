library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity SymbolMultiplier is
	port( uncoded_a, uncoded_b: 
	in std_logic_vector(2 downto 0);
	uncoded_multab: out std_logic_vector(2 downto 0)
	);
end SymbolMultiplier;

architecture Behavioral of SymbolMultiplier is

component BinaryAdderSubtractor is
	port( a,b: in std_logic_vector(3 downto 0);
	fnc: in std_logic;
	s_or_d: out std_logic_vector(3 downto 0)
	);
end component;

component Mux6x3 is
	Port (	a : in std_logic_vector(2 downto 0) ;
		b : in std_logic_vector(2 downto 0) ;
		s : in std_logic ;
		f : out std_logic_vector(2 downto 0));
end component ;

component SymbolPowerDecoder is
    Port ( n1 : in  std_logic_vector(2 downto 0);
           n1c : out  std_logic_vector(2 downto 0));
end component;

component SymbolPowerEncoder is
    Port ( n1 : in  std_logic_vector(2 downto 0);
           n1c : out  std_logic_vector(2 downto 0));
end component;

signal iszero: std_logic;
signal zerov: std_logic_vector(2 downto 0);
signal s_or_d: std_logic_vector(3 downto 0);
signal a: std_logic_vector(2 downto 0);
signal b: std_logic_vector(2 downto 0);
signal uncoded_multab_poly: std_logic_vector(2 downto 0);
signal multab: std_logic_vector(2 downto 0);
signal sa: std_logic_vector(3 downto 0);
signal sb: std_logic_vector(3 downto 0);
signal tt: std_logic;
signal t7: std_logic_vector(3 downto 0);
signal tres: std_logic_vector(3 downto 0);
signal sa2: std_logic_vector(2 downto 0);
signal sb2: std_logic_vector(2 downto 0);

begin

iszero <= (uncoded_a(0) or uncoded_a(1) or uncoded_a(2))
 and (uncoded_b(0) or uncoded_b(1) or uncoded_b(2));

encode1: SymbolPowerEncoder port map(uncoded_a, a);
encode2: SymbolPowerEncoder port map(uncoded_b, b);

sa(0) <= a(0);
sa(1) <= a(1);
sa(2) <= a(2);
sa(3) <= '0';

sb(0) <= b(0);
sb(1) <= b(1);
sb(2) <= b(2);
sb(3) <= '0';

fa0: BinaryAdderSubtractor port map(sa, sb, '0', s_or_d);
tt <= s_or_d(3) or (s_or_d(0) and s_or_d(1) and s_or_d(2));

t7(0) <= '1';
t7(1) <= '1';
t7(2) <= '1';
t7(3) <= '0';
fa1: BinaryAdderSubtractor port map(s_or_d, t7,'1',tres);

sa2(0) <= tres(0);
sa2(1) <= tres(1);
sa2(2) <= tres(2);

sb2(0) <= s_or_d(0);
sb2(1) <= s_or_d(1);
sb2(2) <= s_or_d(2);

mux1: Mux6x3 port map(sa2, sb2, tt, multab);

decode1: SymbolPowerDecoder port map(multab, uncoded_multab_poly);

zerov(0) <= '0';
zerov(1) <= '0';
zerov(2) <= '0';

mux2: Mux6x3 port map(uncoded_multab_poly, zerov, iszero, uncoded_multab);

end Behavioral;
