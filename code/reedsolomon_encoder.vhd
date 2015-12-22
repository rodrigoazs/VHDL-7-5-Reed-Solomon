library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity ReedSolomonEncoder is
    Port ( Clock : in  std_logic;
	Count7 : in  std_logic;
	Qs0 : in std_logic_vector(2 downto 0);
	Qp : out std_logic_vector(2 downto 0));
end ReedSolomonEncoder;

architecture Behavioral of ReedSolomonEncoder is
component flipflop is 
	 Port (	D: in std_logic_vector(2 downto 0) ; 
		Clock : in std_logic;
		Reset : in std_logic;
		Q : out std_logic_vector(2 downto 0)) ; 
end component; 

component AdderXor is
	 Port (	a: in 	std_logic_vector(2 downto 0) ; 
		b: in 	std_logic_vector(2 downto 0);
		c: out 	std_logic_vector(2 downto 0)) ; 
end component;

component Mult is
	port( uncoded_a, uncoded_b:
	in std_logic_vector(2 downto 0);
	uncoded_multab: out std_logic_vector(2 downto 0)
	);
end component;

component mux6 IS
	Port (y1: in 	std_logic_vector(2 downto 0 ) ;
		y0: in 	std_logic_vector(2 downto 0 ) ;
		s: in 	std_logic ;
		f: out 	std_logic_vector(2 downto 0 ));
end component;

signal alpha3 : std_logic_vector(2 downto 0);
signal alpha4 : std_logic_vector(2 downto 0);
signal D1 : std_logic_vector(2 downto 0);
signal D2 : std_logic_vector(2 downto 0);
signal Q1 : std_logic_vector(2 downto 0);
signal Q2 : std_logic_vector(2 downto 0);
signal C0 : std_logic_vector(2 downto 0);
signal multa1 : std_logic_vector(2 downto 0);
signal multa2 : std_logic_vector(2 downto 0);

begin

alpha3(0) <= '0'; alpha3(1) <= '1'; alpha3(2) <= '1';
alpha4(0) <= '1'; alpha4(1) <= '1'; alpha4(2) <= '0';

ff1 : flipflop port map (D1,Clock,Count7,Q1);
ff2 : flipflop port map (D2,Clock,Count7,Q2);

add1 : AdderXor port map (Q2, Qs0, C0);

mult1 : Mult port map (C0, alpha4, multa1);
mult2 : Mult port map (C0, alpha3, multa2);

add2 : AdderXor port map(Q1, multa1, D2);

D1 <= multa2;

Qp <= Q2;

end Behavioral;
