library ieee;
use ieee.std_logic_1164.all;

----defining an and gate
--entity andgate is
--port(a, b: in bit;
--     c: out bit);
--end andgate;
--architecture e1 of andgate is
--begin
--c <= a and b;
--end e1;
--
----defining a not gate
--entity notgate is
--port(a: in bit;
--     c: out bit);
--end notgate;
--architecture e2 of notgate is
--begin
--c <= not a;
--end e2;
--
----defining an or gate
--entity orgate is
--port(a, b: in bit;
--     c: out bit);
--end orgate;
--architecture e3 of orgate is
--begin
--c <= a or b;
--end e3;
--
----defining a xor gate
--entity xorgate is
--port(a, b: in bit;
--     c: out bit);
--end xorgate;
--architecture e4 of xorgate is
--component andgate
--port(a, b: in bit;
--     c: out bit);
--end component;
--component orgate
--port(a, b: in bit;
--     c: out bit);
--end component;
--component notgate
--port(a: in bit;
--     c: out bit);
--end component;
--signal nota,notb,s0,s1: bit;
--begin
--	-- a XOR b = a.b_bar + a_bar.b
--	u0 : notgate 
--		port map(a, nota);
--	u1 : notgate 
--		port map(b, notb);
--	u2 : andgate
--		port map(a, notb, s0);
--	u3 : andgate
--		 port map(b, nota, s1);
--	u4 : orgate
--		port map(s0, s1, c);
--end e4;


-- block that calculates zero output (z)
--entity genZ is
--	port(InBus: in bit_vector(15 downto 0);
--		  en: in bit;
--		  zero: out bit);
--end genZ;
--architecture e5 of genZ is
--component orgate
--port(a, b: in bit;
--     c: out bit);
--end component;
--component notgate
--port(a: in bit;
--     c: out bit);
--end component;
--component andgate
--port(a, b: in bit;
--     c: out bit);
--end component;
--signal x: bit_vector(15 downto 1);
--signal temp: bit;
--begin
--o1: orgate port map(InBus(0), Inbus(1), x(1));
--o2: orgate port map(x(1), Inbus(2), x(2));
--o3: orgate port map(x(2), Inbus(3), x(3));
--o4: orgate port map(x(3), Inbus(4), x(4));
--o5: orgate port map(x(4), Inbus(5), x(5));
--o6: orgate port map(x(5), Inbus(6), x(6));
--o7: orgate port map(x(6), Inbus(7), x(7));
--o8: orgate port map(x(7), Inbus(8), x(8));
--o9: orgate port map(x(8), Inbus(9), x(9));
--o10: orgate port map(x(9), Inbus(10), x(10));
--o11: orgate port map(x(10), Inbus(11), x(11));
--o12: orgate port map(x(11), Inbus(12), x(12));
--o13: orgate port map(x(12), Inbus(13), x(13));
--o14: orgate port map(x(13), Inbus(14), x(14));
--o15: orgate port map(x(14), Inbus(15), x(15));
--
--n1: notgate port map(x(15), temp);
--a1: andgate port map(temp, en, zero);
--end e5;



entity xor_16 is
port(Abus: in bit_vector(15 downto 0);
	  Bbus: in bit_vector(15 downto 0);
	  en: in bit;
	  Cbus_en: out bit_vector(15 downto 0);
	  Z:out bit);
end xor_16;

architecture e of xor_16 is

component xorgate 
port(a, b : in bit;
		z: out bit);
end component;

component andgate
port(a, b: in bit;
		z: out bit);
end component;

component genZ2
	port(InBus: in bit_vector(15 downto 0);
		  en: in bit;
		  zero: out bit);
end component;

signal CBus: bit_vector(15 downto 0);

begin 
	x0: xorgate port map(ABus(0), BBus(0), CBus(0));
	y0: andgate port map(CBus(0), en, CBus_en(0));
	
	x1: xorgate port map(ABus(1), BBus(1), CBus(1));
	y1: andgate port map(CBus(1), en, CBus_en(1));
	
	x2: xorgate port map(ABus(2), BBus(2), CBus(2));
	y2: andgate port map(CBus(2), en, CBus_en(2));
	
	x3: xorgate port map(ABus(3), BBus(3), CBus(3));
	y3: andgate port map(CBus(3), en, CBus_en(3));
	
	x4: xorgate port map(ABus(4), BBus(4), CBus(4));
	y4: andgate port map(CBus(4), en, CBus_en(4));
	
	x5: xorgate port map(ABus(5), BBus(5), CBus(5));
	y5: andgate port map(CBus(5), en, CBus_en(5));
	
	x6: xorgate port map(ABus(6), BBus(6), CBus(6));
	y6: andgate port map(CBus(6), en, CBus_en(6));
	
	x7: xorgate port map(ABus(7), BBus(7), CBus(7));
	y7: andgate port map(CBus(7), en, CBus_en(7));
	
	x8: xorgate port map(ABus(8), BBus(8), CBus(8));
	y8: andgate port map(CBus(8), en, CBus_en(8));
	
	x9: xorgate port map(ABus(9), BBus(9), CBus(9));
	y9: andgate port map(CBus(9), en, CBus_en(9));
	
	x10: xorgate port map(ABus(10), BBus(10), CBus(10));
	y10: andgate port map(CBus(10), en, CBus_en(10));
	
	x11: xorgate port map(ABus(11), BBus(11), CBus(11));
	y11: andgate port map(CBus(11), en, CBus_en(11));

	x12: xorgate port map(ABus(12), BBus(12), CBus(12));
	y12: andgate port map(CBus(12), en, CBus_en(12));

	x13: xorgate port map(ABus(13), BBus(13), CBus(13));
	y13: andgate port map(CBus(13), en, CBus_en(13));

	x14: xorgate port map(ABus(14), BBus(14), CBus(14));
	y14: andgate port map(CBus(14), en, CBus_en(14));
	
	x15: xorgate port map(ABus(15), BBus(15), CBus(15));
	y15: andgate port map(CBus(15), en, CBus_en(15));
	
	z1: genZ2 port map(CBus, en, Z);

end e;