library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity ErrorGuessing is
    Port ( Syndrome: in std_logic_vector(5 downto 0);
           Error: out std_logic_vector(20 downto 0));
end ErrorGuessing;

architecture Behavioral of ErrorGuessing is

begin
process ( Syndrome )
	begin
		case Syndrome is
when "010011"=> Error <="000000000000000000100";
when "010111"=> Error <="000000000000000100000";
when "110111"=> Error <="000000000000100000000";
when "100100"=> Error <="000000000100000000000";
when "110011"=> Error <="000000100000000000000";
when "000100"=> Error <="000100000000000000000";
when "100000"=> Error <="100000000000000000000";
when "001111"=> Error <="000000000000000000010";
when "001101"=> Error <="000000000000000010000";
when "011101"=> Error <="000000000000010000000";
when "010010"=> Error <="000000000010000000000";
when "011111"=> Error <="000000010000000000000";
when "000010"=> Error <="000010000000000000000";
when "010000"=> Error <="010000000000000000000";
when "110101"=> Error <="000000000000000000001";
when "110100"=> Error <="000000000000000001000";
when "111100"=> Error <="000000000000001000000";
when "001001"=> Error <="000000000001000000000";
when "111101"=> Error <="000000001000000000000";
when "000001"=> Error <="000001000000000000000";
when "001000"=> Error <="001000000000000000000";
when "011100"=> Error <="000000000000000000110";
when "011010"=> Error <="000000000000000110000";
when "101010"=> Error <="000000000000110000000";
when "110110"=> Error <="000000000110000000000";
when "101100"=> Error <="000000110000000000000";
when "000110"=> Error <="000110000000000000000";
when "110000"=> Error <="110000000000000000000";
when "111010"=> Error <="000000000000000000011";
when "111001"=> Error <="000000000000000011000";
when "100001"=> Error <="000000000000011000000";
when "011011"=> Error <="000000000011000000000";
when "100010"=> Error <="000000011000000000000";
when "000011"=> Error <="000011000000000000000";
when "011000"=> Error <="011000000000000000000";
when "101001"=> Error <="000000000000000000111";
when "101110"=> Error <="000000000000000111000";
when "010110"=> Error <="000000000000111000000";
when "111111"=> Error <="000000000111000000000";
when "010001"=> Error <="000000111000000000000";
when "000111"=> Error <="000111000000000000000";
when "111000"=> Error <="111000000000000000000";
when "100110"=> Error <="000000000000000000101";
when "100011"=> Error <="000000000000000101000";
when "001011"=> Error <="000000000000101000000";
when "101101"=> Error <="000000000101000000000";
when "001110"=> Error <="000000101000000000000";
when "000101"=> Error <="000101000000000000000";
when "101000"=> Error <="101000000000000000000";
when OTHERS   => Error <="000000000000000000000";
		end case;
	end process;

end Behavioral;

