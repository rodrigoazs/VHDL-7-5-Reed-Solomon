library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity write_error is
	port (clock: in std_logic;
		message: in std_logic_vector(14 downto 0)
	);
end write_error;

architecture behavioral of write_error is

signal counter_write: std_logic_vector(2 downto 0)
 := "000";
begin

process(clock)
  file file_pointer : text;
    variable line_content : string(1 to 15);
    variable line_num : line;
    variable i,j : integer := 0;
    variable char : character:='0';
begin
if (clock'event and clock='1') then
  counter_write <= counter_write + 1;
  if(i = 0 and counter_write = "111") then
	file_open(file_pointer,"write_error.txt",write_mode);
  end if;
  if (counter_write = "111") then
	  for j in 0 to 14 loop
		if(message(j) = '0') then
			 line_content(15-j) := '0';
		else
			 line_content(15-j) := '1';
		end if;
	  end loop;
	  write(line_num,line_content);
	  writeline (file_pointer,line_num);
	  i := 1;
	  counter_write <= "001";
  end if;
end if;
end process;

end behavioral;
