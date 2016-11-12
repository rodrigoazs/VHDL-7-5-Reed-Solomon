library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity read_file is
	Port (Clock: in std_logic;
		Qout: out std_logic_vector(2 downto 0)
	);
end read_file;

architecture Behavioral of read_file is

signal bin_value : std_logic_vector(2 downto 0):="000";
   
begin
   
    process
      file file_pointer : text;
        variable line_content : string(1 to 15);
      variable line_num : line;
        variable j, i : integer := 0;
        variable char : character:='0';
   begin
      file_open(file_pointer,"read.txt",READ_MODE);   
      bin_value <= "UUU";
		wait for 1 ps;
		while not endfile(file_pointer) loop
      readline (file_pointer,line_num);
      READ (line_num,line_content);
        for j in 1 to 15 loop
	    i := i + 1;
            char := line_content(16-j);
            if(char = '0') then
                bin_value(i-1) <= '0';
            else
                bin_value(i-1) <= '1';
            end if;
				if (i = 3) then
					i := 0;
				   wait for 2 ps;
				end if;
        end loop;
		  bin_value <= "UUU";
		  wait for 4 ps;
      end loop;
      file_close(file_pointer);
        wait;
    end process;
	 
	 Qout <= bin_value;

end Behavioral;
