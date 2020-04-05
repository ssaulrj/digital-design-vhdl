----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:16:56 10/25/2017 
-- Design Name: 
-- Module Name:    Display - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Display is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           D : out  STD_LOGIC_VECTOR (7 downto 0);
			  AN : out STD_LOGIC_VECTOR (3 downto 0));
end Display;

architecture Behavioral of Display is

begin

Disp: Process (A) 
begin
if(A="0000") then
AN<="0111";
D<="11000000";

elsif(A="0001") then
AN<="1011";
D<="11111001";

elsif(A="0010") then
AN<="1101";
D<="10100100";

elsif(A="0011") then
AN<="1110";
D<="10110000";

elsif(A="0100") then
AN<="0111";
D<="10011001";

elsif(A="0101") then
AN<="1011";
D<="10010010";

elsif(A="0110") then
AN<="1101";
D<="10000010";

elsif(A="0111") then
AN<="1110";
D<="10000000";

elsif(A="1000") then
AN<="0111";
D<="10011000";

elsif(A="1001") then
AN<="1011";
D<="10001000";

elsif(A="1010") then
AN<="1101";
D<="10001000";

elsif(A="1011") then
AN<="1110";
D<="10000011";

elsif(A="1100") then
AN<="0111";
D<="11000110";

elsif(A="1101") then
AN<="1011";
D<="10100001";

elsif(A="1110") then
AN<="1101";
D<="10000110";

elsif(A="1111") then
AN<="1101";
D<="10001110";

 end if;
 end Process;



end Behavioral;






net "A(0)" LOC = H13;
net "A(1)" LOC = E18;
net "A(2)" LOC = D18;
net "A(3)" LOC = B18;
net "D(0)" LOC = L18;
net "D(1)" LOC = F18;
net "D(2)" LOC = D17;
net "D(3)" LOC = D16;
net "D(4)" LOC = G14;
net "D(5)" LOC = J17;
net "D(6)" LOC = H14;
net "D(7)" LOC = C17;
net "AN(0)" LOC = F17;
net "AN(1)" LOC = H17;
net "AN(2)" LOC = C18;
net "AN(3)" LOC = F15;
