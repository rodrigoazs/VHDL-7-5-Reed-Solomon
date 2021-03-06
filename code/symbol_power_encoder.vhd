library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity SymbolPowerEncoder is
    Port ( n1 : in  std_logic_vector(2 downto 0);
           n1c : out  std_logic_vector(2 downto 0));
end SymbolPowerEncoder;

architecture Behavioral of SymbolPowerEncoder is

begin
process ( n1 )
	begin
		case n1 is
			when "100"=> n1c <="000" ;
			when "010"=> n1c <="001" ;
			when "001"=> n1c <="010" ;
			when "110"=> n1c <="011" ;
			when "011"=> n1c <="100" ;
			when "111"=> n1c <="101" ;
			when "101"=> n1c <="110" ;
			when others=> n1c <="---" ;
		end case ;
	end process ;

end Behavioral;
