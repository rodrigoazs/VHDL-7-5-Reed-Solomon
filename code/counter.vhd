library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Author: R. Azevedo Santos (rodrigo4zevedo@gmail.com)
-- Co-Author: Joao Lucas Magalini Zago
--
-- VHDL Implementation of (7,5) Reed Solomon
-- Course: Information Theory - 2014 - Ohio Northern University

entity counter is
   port(Clock: in std_logic;
	 Count5: out std_logic;
	 Count7: out std_logic);
end counter;
 
architecture Behavioral of counter is
   signal temp: std_logic_vector(0 to 2) := "000";

begin process(Clock)
   begin
		if(Clock'event and Clock='0') then
			if temp = "000" or temp = "111"
			then
				Count7 <= '1';
			else
				Count7 <= '0';
			end if;
		end if;
      if(Clock'event and Clock='1') then
			Count7 <= '0';
		 if temp="101" or temp="110" then
		    Count5 <= '1';
		 else
		    Count5 <= '0';
	    end if;
	    if temp="111" then
	       temp<="001";
	    else
	       temp <= temp + 1;
	    end if;
      end if;
   end process;
end Behavioral;
