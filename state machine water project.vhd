----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:27:13 12/09/2017 
-- Design Name: 
-- Module Name:    MaquinadeEstados2 - Arq_maquina2 
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
Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

Entity MaquinadeEstados2 is
port(   sentrada: in std_logic_vector (0 to 2);
        clk_50 : in  STD_LOGIC;
	clk1: inout std_logic;
	sresetH: in std_logic;
	señal_de_salida1: out std_logic_vector (0 to 1);
	--señal_de_salida2: out std_logic;
	D : out  STD_LOGIC_VECTOR (0 to 7);
        AN : out  STD_LOGIC_VECTOR (0 to 3)  );
end MaquinadeEstados2;

Architecture Arq_maquina2 of MaquinadeEstados2 is
TYPE TipoEstados is (E0,E1,E2,E3);
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
				if (sentrada="111") then
				edo_siguiente <= E3;
				elsif (sentrada="011") then
				edo_siguiente <= E2;
				elsif (sentrada="001") then
				edo_siguiente <= E1;
				elsif (sentrada="000") then
				edo_siguiente <= E0;
				ELSE
				edo_siguiente <= E0;
				end if;
			when E1=> 
								AN<="0111"; 
								D<="11111001"; --1
				if (sentrada="111") then
				edo_siguiente <= E1;				
				ELSif (sentrada="011") then
				edo_siguiente <= E2;
				elsif (sentrada="001") then
				edo_siguiente <= E1;
				elsif (sentrada="000") then
				edo_siguiente <= E0;
				ELSE
				edo_siguiente <= E1;
				end if;
			when E2=>      
								AN<="0111"; 
								D<="10100100"; --2                   
				if (sentrada="111") then
				edo_siguiente <= E3;
				elsif (sentrada="011") then
				edo_siguiente <= E2;
				elsif (sentrada="001") then
				edo_siguiente <= E1;
				elsif (sentrada="000") then
				edo_siguiente <= E2;
				ELSE
				edo_siguiente <= E2;
				end if;
			when E3=> 
								AN<="0111"; 
								D<="10110000"; --3				
				if (sentrada="000") then
				edo_siguiente <= E0;
				elsif (sentrada="111") then
				edo_siguiente <= E3;
				elsif (sentrada="011") then
				edo_siguiente <= E3;
				elsif (sentrada="001") then
				edo_siguiente <= E3;
				ELSE
				edo_siguiente <= E3;
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

NOM : PROCESS (EDO_ACTUAL,SENTRADA)
	BEGIN
--Combinacion flujo de datos y funcional
IF edo_actual=E0 THEN señal_de_salida1 <= "10"; END IF;
IF edo_actual=E1 THEN señal_de_salida1 <= "11"; END IF;
IF edo_actual=E2 THEN señal_de_salida1 <= "01"; END IF;
IF edo_actual=E3 THEN señal_de_salida1 <= "01"; END IF;
----estado de vacio 
IF edo_actual=E0 and sentrada="111" THEN señal_de_salida1 <= "00" ; END IF;
IF edo_actual=E0 and sentrada="011" THEN señal_de_salida1 <= "01" ; END IF;
IF edo_actual=E0 and sentrada="001" THEN señal_de_salida1 <= "00" ; END IF;
IF edo_actual=E0 and sentrada="000" THEN señal_de_salida1 <= "00" ; END IF;
--   
----estado de normal 
IF edo_actual=E1 and sentrada="011" THEN señal_de_salida1 <= "01" ; END IF;
IF edo_actual=E1 and sentrada="001" THEN señal_de_salida1 <= "11" ; END IF;
IF edo_actual=E1 and sentrada="000" THEN señal_de_salida1 <= "10" ; END IF;
--
----estado de lleno
IF edo_actual=E2 and sentrada="111" THEN señal_de_salida1 <= "01" ; END IF;
IF edo_actual=E2 and sentrada="011" THEN señal_de_salida1 <= "01" ; END IF;
IF edo_actual=E2 and sentrada="001" THEN señal_de_salida1 <= "11" ; END IF;
--
----estado de alarma
IF edo_actual=E3 and sentrada="111" THEN señal_de_salida1 <= "01" ; END IF;
IF edo_actual=E3 and sentrada="011" THEN señal_de_salida1 <= "01" ; END IF;
IF edo_actual=E3 and sentrada="001" THEN señal_de_salida1 <= "01" ; END IF;
IF edo_actual=E3 and sentrada="000" THEN señal_de_salida1 <= "10" ; END IF;

END PROCESS NOM;


end Arq_maquina2;



-----------------------------------------------------------------PUERTOS

net CLK_50 LOC= B8;
net clk1 LOC= L15;

NET "sentrada(0)" LOC = R17 ;
NET "sentrada(1)" LOC = N17 ;
NET "sentrada(2)" LOC = L13 ;
NET "sresetH" LOC = H18 ;
NET "señal_de_salida1(0)" LOC = J15 ;
NET "señal_de_salida1(1)" LOC = J14 ;

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
