library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Disp is Port ( clk_50 : in  STD_LOGIC;
           clk_1seg : inout  STD_LOGIC);
end Disp;

architecture Behavioral of Disp is
signal ent: std_logic_vector (0 to 25);

begin
cirReloj: Process(clk_50) begin
		
		if(clk_50' event and clk_50 = '1') then
			if(ent=25000000) then
			clk_1seg<='0';
			else
				ent <= ent+1;
			end if;
		
		if(ent=50000000) then
		CLK_1seg<='1';
		ent<="00000000000000000000000000";
		else
		ent<=ent+1;
		end if;
		end if;
		
	end process cirReloj;	



end Behavioral;
