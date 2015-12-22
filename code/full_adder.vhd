library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity fa is
    Port ( a : in  std_logic;
           b : in  std_logic;
           c : in  std_logic;
           sum1 : out std_logic;
           sum0 : out std_logic);
end fa;

architecture Behavioral of fa is

signal s1 : std_logic;
signal s2 : std_logic;
signal s3 : std_logic;
signal s4 : std_logic;
signal s5 : std_logic;
signal s6 : std_logic;
signal s7 : std_logic;
signal s8 : std_logic;

begin

    s1 <= (not a) and b and c;
    s2 <= a and (not b) and c;
    s3 <= a and b and (not c);
    s4 <= a and b and c;
    sum1 <= s1 or s2 or s3 or s4;
    s5 <= (not a) and b and (not c);
    s6 <= a and (not b) and (not c);
    s7 <= (not a) and (not b) and c;
    s8 <= a and b and c;
    sum0 <= s5 or s6 or s7 or s8;

end Behavioral;
