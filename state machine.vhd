Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity MaquinadeEstados is
port(   sentrada: in std_logic;
        clk_50 : in  STD_LOGIC;
	clk1: in std_logic;
	sresetH: in std_logic;
	señal_de_salida1: out std_logic;
	señal_de_salida2: out std_logic;
	D : out  STD_LOGIC_VECTOR (0 to 7);
        AN : out  STD_LOGIC_VECTOR (0 to 3)  );
end MaquinadeEstados;

Architecture Arq_maquina of MaquinadeEstados is
TYPE TipoEstados is (E0,E1,E2,E3,E4);
signal edo_actual, edo_siguiente: TipoEstados;
signal cnt: STD_LOGIC_VECTOR (0 to 25);

begin

	relojj: Process(clk_50) begin
			if(clk_50' event and clk_50 = '1') then
			   if(cnt=25000000) then
				clk1<='0';
				else
				cnt <= cnt+1;
			   end if;
		
			   if(cnt=50000000) then
				clk1<='1';
				cnt<="00000000000000000000000000";
				else
				cnt<=cnt+1;
			   end if;
			end if;	
	end Process relojj;	

	Logica_estado: Process(edo_actual,sentrada)
	begin
		case (edo_actual) is 
			when E0=> 
				AN<="0111";
				D<="11000000"; --0
				if (sentrada='1') then
				AN<="0111"; 
				D<="00000110"; --1
				edo_siguiente <= E1;
				else
				AN<="0111";
				D<="10011001"; --4
				edo_siguiente <= E4;
				end if;
			when E1=> 
				AN<="0111"; 
				D<="00000110"; --1
				if (sentrada='1') then
				AN<="0111"; 
				D<="10100100"; --2
				edo_siguiente <= E2;
				else
				AN<="0111";
				D<="10011001"; --4
				edo_siguiente <= E4;
				end if;
			when E2=> 
				AN<="0111"; 
				D<="10100100"; --2
				if (sentrada='1') then
				AN<="0111"; 
				D<="10110000"; --3
				edo_siguiente <= E3;
				else
				AN<="0111";
				D<="10011001"; --4
				edo_siguiente <= E4;
				end if;
			when E3=> 
				AN<="0111"; 
				D<="10110000"; --3
				edo_siguiente <= E3;

			when E4=> 
				AN<="0111";
				D<="10011001"; --4
				if (sentrada='1') then
				AN<="0111"; 
				D<="00000110"; --1
				edo_siguiente <= E1;
				else
				AN<="0111";
				D<="10011001"; --4
				edo_siguiente <= E4;
				end if;
		end case;
	end process Logica_estado;
	
	Mem_Estado: Process(clk1,sresetH,edo_siguiente)
	begin
				if (sresetH='1') then
				edo_actual <= E0;
				elsif (rising_edge(clk1)) then 
				edo_actual <= edo_siguiente;
				end if;
	end process Mem_Estado;

--Combinacion flujo de datos y funcional
   señal_de_salida1 <= '1' when (edo_actual=E2 and sentrada='1') 
   else '0';

   señal_de_salida2 <= '1' when (edo_actual=E2) 
   else '0';

end Arq_maquina;

-----------------------------------------------------------------PUERTOS

net CLK_50 LOC= B8;
net clk1 LOC= L15;

NET "sentrada" LOC = G18;
NET "sresetH" LOC = H18;
NET "señal_de_salida1" LOC = J14;
NET "señal_de_salida2" LOC = J15;

net "D(7)" LOC= L18;
net "D(6)" LOC= F18;
net "D(5)" LOC= D17;
net "D(4)" LOC= D16;
net "D(3)" LOC= G14;
net "D(2)" LOC= J17;
net "D(1)" LOC= H14;
net "D(0)" LOC= C17;

net "AN(0)" LOC=F17;
net "AN(1)" LOC=H17;
net "AN(2)" LOC=C18;
net "AN(3)" LOC=F15;
