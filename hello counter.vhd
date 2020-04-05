CONTADOR HOLA

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Contador_hola is
    Port ( x : in  STD_LOGIC;
           clk_50 : in  STD_LOGIC;
           clk_1seg : inout  STD_LOGIC;
           z : out  STD_LOGIC_VECTOR (0 to 1);
           D : out  STD_LOGIC_VECTOR (0 to 7);
           AN : out  STD_LOGIC_VECTOR (0 to 3));
end Contador_hola;

architecture Behavioral of Contador_hola is

signal cnt: STD_LOGIC_VECTOR (0 to 25);
TYPE estados is (E0, E1, E2, E3);
signal edo_presente, edo_futuro: estados;

begin

Process(clk_50) begin
		
		if(clk_50' event and clk_50 = '1') then
			if(cnt=25000000) then
			clk_1seg<='0';
			else
				cnt <= cnt+1;
			end if;
		
		if(cnt=50000000) then
		CLK_1seg<='1';
		cnt<="00000000000000000000000000";
		else
		cnt<=cnt+1;
		end if;
		end if;
		
	end Process;
	
Process(clk_1seg, x) begin

case edo_presente is

when E0=> z <= "00";
if (x='1') then
edo_futuro<= E1;
AN<="1110";
D<="10001001";
else
edo_futuro<= E0;
end if;

when E1=> z <= "01";
if (x='1') then
edo_futuro<= E2;
AN<="1101";
D<="11000000";
else
edo_futuro<= E1;
end if;

when E2=> z <= "10";
if (x='1') then
edo_futuro<= E3;
AN<="1011";
D<="11000111";
else
edo_futuro<= E2;
end if;

when E3=> z <= "11";
if (x='1') then
edo_futuro<= E0;
AN<="0111";
D<="10001000";
else
edo_futuro<= E3;
end if;
end case;
end Process;

Process(CLK_1seg) begin
if (CLK_1seg' event and CLK_1seg='1') then
edo_presente<= edo_futuro;
end if;
end Process;




end Behavioral;

--------------------------------------------------

net CLK_50 LOC= V10;
net CLK_1seg LOC= M11;
net "x" LOC= T10;
#net z(0) LOC= U16;
#net z(1) LOC= V16;

net "D(7)" LOC = T17;
net "D(6)" LOC = T18;
net "D(5)" LOC = U17;
net "D(4)" LOC = U18;
net "D(3)" LOC = M14;
net "D(2)" LOC = N14;
net "D(1)" LOC = L14;
net "D(0)" LOC = M13;

net "AN(0)" LOC= N16;
net "AN(1)" LOC= N15;
net "AN(2)" LOC= P18;
net "AN(3)" LOC= P17;
