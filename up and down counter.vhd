Library ieee; 

entity diagrama is port(
			clk_1hz: in std_logic;
			clk, x : in std_logic;
			z: out std_logic_vector(0 to 1) );
end diagrama

architecture Arq_diagrama of diagrama is

TYPE estados is (E0, E1, E2, E3);
signal edo_presente, edo_futuro: estados;
signal_ent (0 to 25);

begin
	
	proceso1: process(edo_presente, x) begin
		case edo_presente is
			when E0 => z <= "00";
			if(x='1') then
				edo_futuro <= E1;
			else
				edo_futuro <= E3;
			end if;

			when E1 => z <= "01";
			if(x='1') then
				edo_futuro <= E2;
			else
				edo_futuro <= E0;
			end if;

			when E2 => z <= "10";
			if(x='1') then
				edo_futuro <= E3;
			else
				edo_futuro <= E1;
			end if;

			when E3 => z <= "11";
			if(x='1') then
				edo_futuro <= E0;
			else
				edo_futuro <= E2;
			end if;
		end case; 
	end process proceso1;

	proceso2: process(clk_1hz) begin
		if(clk_1hz'event and clk_1hz='1') then
		edo_presente <= edo_futuro; 
		end if;
	end process proceso2;

	proceso3: process(clk) begin

	end process proceso3;

end Arq_diagrama;
