library ieee;
use ieee.std_logic_1164.all;

--defining an and gate
entity andgate is
port(a, b: in bit;
     z: out bit);
end andgate;
architecture e1 of andgate is
begin
z <= a and b;
end e1;

--defining a not gate
entity notgate is
port(a: in bit;
     z: out bit);
end notgate;
architecture e2 of notgate is
begin
z <= not a;
end e2;

--defining an or gate
entity orgate is
port(a, b: in bit;
     z: out bit);
end orgate;
architecture e3 of orgate is
begin
z <= a or b;
end e3;

--defining a xor gate
entity xorgate is
port(a, b: in bit;
     z: out bit);
end xorgate;
architecture e4 of xorgate is
component andgate
port(a, b: in bit;
     z: out bit);
end component;
component orgate
port(a, b: in bit;
     z: out bit);
end component;
component notgate
port(a: in bit;
     z: out bit);
end component;
signal nota,notb,s0,s1: bit;
begin
	-- a XOR b = a.b_bar + a_bar.b
	u0 : notgate 
		port map(a, nota);
	u1 : notgate 
		port map(b, notb);
	u2 : andgate
		port map(a, notb, s0);
	u3 : andgate
		 port map(b, nota, s1);
	u4 : orgate
		port map(s0, s1, z);
end e4;


-- block that computes g_i, p_i from a_i and b_i for i = 0, 1, ... 15
entity gpGenerator is
	port(ABus: in bit_vector(15 downto 0);
		  BBus: in bit_vector(15 downto 0);
		  gBus: out bit_vector(15 downto 0);
	     pBus: out bit_vector(15 downto 0));
end gpGenerator;
architecture e5 of gpGenerator is
-- using and, xor gate as components
component andgate
port(a, b: in bit;
     z: out bit);
end component;
component xorgate
port(a, b: in bit;
     z: out bit);
end component;

begin
	-- p_i = a_i XOR b_i
	x0: xorgate port map(ABus(0), BBus(0), pBus(0));
	x1: xorgate port map(ABus(1), BBus(1), pBus(1));
	x2: xorgate port map(ABus(2), BBus(2), pBus(2));
	x3: xorgate port map(ABus(3), BBus(3), pBus(3));
	x4: xorgate port map(ABus(4), BBus(4), pBus(4));
	x5: xorgate port map(ABus(5), BBus(5), pBus(5));
	x6: xorgate port map(ABus(6), BBus(6), pBus(6));
	x7: xorgate port map(ABus(7), BBus(7), pBus(7));
	x8: xorgate port map(ABus(8), BBus(8), pBus(8));
	x9: xorgate port map(ABus(9), BBus(9), pBus(9));
	x10: xorgate port map(ABus(10), BBus(10), pBus(10));
	x11: xorgate port map(ABus(11), BBus(11), pBus(11));
	x12: xorgate port map(ABus(12), BBus(12), pBus(12));
	x13: xorgate port map(ABus(13), BBus(13), pBus(13));
	x14: xorgate port map(ABus(14), BBus(14), pBus(14));
	x15: xorgate port map(ABus(15), BBus(15), pBus(15));

	-- g_i = a_i AND b_i
	a0: andgate port map(ABus(0), BBus(0), gBus(0));
	a1: andgate port map(ABus(1), BBus(1), gBus(1));
	a2: andgate port map(ABus(2), BBus(2), gBus(2));
	a3: andgate port map(ABus(3), BBus(3), gBus(3));
	a4: andgate port map(ABus(4), BBus(4), gBus(4));
	a5: andgate port map(ABus(5), BBus(5), gBus(5));
	a6: andgate port map(ABus(6), BBus(6), gBus(6));
	a7: andgate port map(ABus(7), BBus(7), gBus(7));
	a8: andgate port map(ABus(8), BBus(8), gBus(8));
	a9: andgate port map(ABus(9), BBus(9), gBus(9));
	a10: andgate port map(ABus(10), BBus(10), gBus(10));
	a11: andgate port map(ABus(11), BBus(11), gBus(11));
	a12: andgate port map(ABus(12), BBus(12), gBus(12));
	a13: andgate port map(ABus(13), BBus(13), gBus(13));
	a14: andgate port map(ABus(14), BBus(14), gBus(14));
	a15: andgate port map(ABus(15), BBus(15), gBus(15));
end e5;

-- block that calculates G_i:k and P_i:k from G_i:j, P_i:j and G_j-1:k, P_j-1:k
entity GPcell is
	port(g1, p1, g2, p2: in bit;
		  G, P: out bit);
end GPcell;

architecture e6 of GPcell is
-- using and, or gates as components
component andgate
port(a, b: in bit;
     z: out bit);
end component;
component orgate
port(a, b: in bit;
     z: out bit);
end component;
signal x: bit;
begin
	-- G_i:k = G_i:j + P_i:j . G_j-1:k
	-- P_i:k = P_i:j . P_j-1:k
	a0: andgate port map(g2, p1, x);
	o0: orgate port map(g1, x, G);
	a1: andgate port map(p1, p2, P);
end e6;

-- block that computes the carry - C_i+1 from G_i:0, P_i:0, C_0  
entity carryGen is
	port(G_in, P_in, c_0: in bit;
		  z: out bit);
end carryGen;

architecture e7 of carryGen is
-- using and, or gates as components
component andgate
port(a, b: in bit;
     z: out bit);
end component;
component orgate
port(a, b: in bit;
     z: out bit);
end component;
signal x: bit;
begin
	-- C_i+1 = G_i:0 + P_i:0 . C_0 
	a0: andgate port map(P_in, c_0, x);
	o0: orgate port map(G_in, x, z);
end e7;	  

entity enabler is
	port(Bus_in: in bit_vector(15 downto 0);
		  c_in: in bit;
		  enable: in bit;
		  Bus_out: out bit_vector(15 downto 0);
		  c_out: out bit);
end enabler;

-- block that will implement enable
architecture e8 of enabler is
-- using and gate as a component
component andgate
port(a, b: in bit;
     z: out bit);
end component;
begin
a0 : andgate port map(Bus_in(0), enable, Bus_out(0));
a1 : andgate port map(Bus_in(1), enable, Bus_out(1));
a2 : andgate port map(Bus_in(2), enable, Bus_out(2));
a3 : andgate port map(Bus_in(3), enable, Bus_out(3));
a4 : andgate port map(Bus_in(4), enable, Bus_out(4));
a5 : andgate port map(Bus_in(5), enable, Bus_out(5));
a6 : andgate port map(Bus_in(6), enable, Bus_out(6));
a7 : andgate port map(Bus_in(7), enable, Bus_out(7));
a8 : andgate port map(Bus_in(8), enable, Bus_out(8));
a9 : andgate port map(Bus_in(9), enable, Bus_out(9));
a10 : andgate port map(Bus_in(10), enable, Bus_out(10));
a11 : andgate port map(Bus_in(11), enable, Bus_out(11));
a12 : andgate port map(Bus_in(12), enable, Bus_out(12));
a13 : andgate port map(Bus_in(13), enable, Bus_out(13));
a14 : andgate port map(Bus_in(14), enable, Bus_out(14));
a15 : andgate port map(Bus_in(15), enable, Bus_out(15));
a16 : andgate port map(c_in, enable, c_out);
end e8;

-- block that calculates zero output (z)
entity genZ is
	port(SumBus: in bit_vector(15 downto 0);
 		  Carrybit: in bit;
		  en: in bit;
		  zero: out bit);
end genZ;
architecture e9 of genZ is
component orgate
port(a, b: in bit;
     z: out bit);
end component;
component notgate
port(a: in bit;
     z: out bit);
end component;
component andgate
port(a, b: in bit;
     z: out bit);
end component;
signal x: bit_vector(16 downto 1);
signal temp: bit;
begin
o1: orgate port map(SumBus(0), Sumbus(1), x(1));
o2: orgate port map(x(1), Sumbus(2), x(2));
o3: orgate port map(x(2), Sumbus(3), x(3));
o4: orgate port map(x(3), Sumbus(4), x(4));
o5: orgate port map(x(4), Sumbus(5), x(5));
o6: orgate port map(x(5), Sumbus(6), x(6));
o7: orgate port map(x(6), Sumbus(7), x(7));
o8: orgate port map(x(7), Sumbus(8), x(8));
o9: orgate port map(x(8), Sumbus(9), x(9));
o10: orgate port map(x(9), Sumbus(10), x(10));
o11: orgate port map(x(10), Sumbus(11), x(11));
o12: orgate port map(x(11), Sumbus(12), x(12));
o13: orgate port map(x(12), Sumbus(13), x(13));
o14: orgate port map(x(13), Sumbus(14), x(14));
o15: orgate port map(x(14), Sumbus(15), x(15));
o16: orgate port map(x(15), Carrybit, x(16));

n1: notgate port map(x(16), temp);
a1: andgate port map(temp, en, zero);
end e9;

	
-- block that implements a Kogge-Stone adder
entity PrefixAdder is
	port(ABus: in bit_vector(15 downto 0);  -- first numeber input port
		  BBus: in bit_vector(15 downto 0);  -- second number input port
		  c0: in bit;                        -- initial carry (used for generating 2's compliment)
		  e: in bit;                         -- enable port
	     carry: out bit;	                   -- output carry
		  Z: out bit;
		  Sum: out bit_vector(15 downto 0)); -- sum vector output port
end PrefixAdder;

architecture e10 of PrefixAdder is
-- using gpGenerator, GPcell, carryGen blocks and xor gate as components
component gpGenerator
port(ABus: in bit_vector(15 downto 0);
		  BBus: in bit_vector(15 downto 0);
		  gBus: out bit_vector(15 downto 0);
	     pBus: out bit_vector(15 downto 0));
end component;
component GPcell
port(g1, p1, g2, p2: in bit;
		  G, P: out bit);
end component;
component carryGen
port(G_in, P_in, c_0: in bit;
		  z: out bit);
end component;
component xorgate
port(a, b: in bit;
     z: out bit);
end component;
component enabler
	port(Bus_in: in bit_vector(15 downto 0);
		  c_in: in bit;
		  enable: in bit;
		  Bus_out: out bit_vector(15 downto 0);
		  c_out: out bit);
end component;
component genZ
	port(SumBus: in bit_vector(15 downto 0);
 		  Carrybit: in bit;
		  en: in bit;
		  zero: out bit);
end component;

signal gBus, pBus: bit_vector(15 downto 0);    -- the g_is and p_is computed in pre-processing
signal G1, P1: bit_vector(15 downto 1);        -- the Gs, Ps after one level of GPcells (prefix computation stage)
signal G2, P2: bit_vector(15 downto 2);        -- the Gs, Ps after two levels of GPcells (prefix computation stage)
signal G3, P3: bit_vector(15 downto 4);        -- the Gs, Ps after three levels of GPcells (prefix computation stage)
signal G4, P4: bit_vector(15 downto 8);        -- the Gs, Ps after four levels of GPcells (prefix computation stage)
signal C: bit_vector(16 downto 0);             -- The carry vector where C(16) is Carry 
signal S: bit_vector(15 downto 0);             -- The sum vector
signal S_e: bit_vector(15 downto 0);           -- output after enabling
signal m1, m2: bit;

begin
-- computing g_is and p_is
gpgen: gpGenerator port map(ABus, BBus, gBus, pBus);

-- first level of GPcellsx
la1: GPcell port map(gBus(1), pBus(1), gBus(0), pBus(0), G1(1), P1(1));
la2: GPcell port map(gBus(2), pBus(2), gBus(1), pBus(1), G1(2), P1(2));
la3: GPcell port map(gBus(3), pBus(3), gBus(2), pBus(2), G1(3), P1(3));
la4: GPcell port map(gBus(4), pBus(4), gBus(3), pBus(3), G1(4), P1(4));
la5: GPcell port map(gBus(5), pBus(5), gBus(4), pBus(4), G1(5), P1(5));
la6: GPcell port map(gBus(6), pBus(6), gBus(5), pBus(5), G1(6), P1(6));
la7: GPcell port map(gBus(7), pBus(7), gBus(6), pBus(6), G1(7), P1(7));
la8: GPcell port map(gBus(8), pBus(8), gBus(7), pBus(7), G1(8), P1(8));
la9: GPcell port map(gBus(9), pBus(9), gBus(8), pBus(8), G1(9), P1(9));
la10: GPcell port map(gBus(10), pBus(10), gBus(9), pBus(9), G1(10), P1(10));
la11: GPcell port map(gBus(11), pBus(11), gBus(10), pBus(10), G1(11), P1(11));
la12: GPcell port map(gBus(12), pBus(12), gBus(11), pBus(11), G1(12), P1(12));
la13: GPcell port map(gBus(13), pBus(13), gBus(12), pBus(12), G1(13), P1(13));
la14: GPcell port map(gBus(14), pBus(14), gBus(13), pBus(13), G1(14), P1(14));
la15: GPcell port map(gBus(15), pBus(15), gBus(14), pBus(14), G1(15), P1(15));

-- second level of GPcells
lb2: GPcell port map(G1(2), P1(2), gBus(0), pBus(0), G2(2), P2(2));
lb3: GPcell port map(G1(3), P1(3), G1(1), P1(1), G2(3), P2(3));
lb4: GPcell port map(G1(4), P1(4), G1(2), P1(2), G2(4), P2(4));
lb5: GPcell port map(G1(5), P1(5), G1(3), P1(3), G2(5), P2(5));
lb6: GPcell port map(G1(6), P1(6), G1(4), P1(4), G2(6), P2(6));
lb7: GPcell port map(G1(7), P1(7), G1(5), P1(5), G2(7), P2(7));
lb8: GPcell port map(G1(8), P1(8), G1(6), P1(6), G2(8), P2(8));
lb9: GPcell port map(G1(9), P1(9), G1(7), P1(7), G2(9), P2(9));
lb10: GPcell port map(G1(10), P1(10), G1(8), P1(8), G2(10), P2(10));
lb11: GPcell port map(G1(11), P1(11), G1(9), P1(9), G2(11), P2(11));
lb12: GPcell port map(G1(12), P1(12), G1(10), P1(10), G2(12), P2(12));
lb13: GPcell port map(G1(13), P1(13), G1(11), P1(11), G2(13), P2(13));
lb14: GPcell port map(G1(14), P1(14), G1(12), P1(12), G2(14), P2(14));
lb15: GPcell port map(G1(15), P1(15), G1(13), P1(13), G2(15), P2(15));

-- third level of GPcells
lc4: GPcell port map(G2(4), P2(4), gBus(0), pBus(0), G3(4), P3(4));
lc5: GPcell port map(G2(5), P2(5), G1(1), P1(1), G3(5), P3(5));
lc6: GPcell port map(G2(6), P2(6), G2(2), P2(2), G3(6), P3(6));
lc7: GPcell port map(G2(7), P2(7), G2(3), P2(3), G3(7), P3(7));
lc8: GPcell port map(G2(8), P2(8), G2(4), P2(4), G3(8), P3(8));
lc9: GPcell port map(G2(9), P2(9), G2(5), P2(5), G3(9), P3(9));
lc10: GPcell port map(G2(10), P2(10), G2(6), P2(6), G3(10), P3(10));
lc11: GPcell port map(G2(11), P2(11), G2(7), P2(7), G3(11), P3(11));
lc12: GPcell port map(G2(12), P2(12), G2(8), P2(8), G3(12), P3(12));
lc13: GPcell port map(G2(13), P2(13), G2(9), P2(9), G3(13), P3(13));
lc14: GPcell port map(G2(14), P2(14), G2(10), P2(10), G3(14), P3(14));
lc15: GPcell port map(G2(15), P2(15), G2(11), P2(11), G3(15), P3(15));

-- fourth level of GPcells
ld8: GPcell port map(G3(8), P3(8), gBus(0), pBus(0), G4(8), P4(8));
ld9: GPcell port map(G3(9), P3(9), G1(1), P1(1), G4(9), P4(9));
ld10: GPcell port map(G3(10), P3(10), G2(2), P2(2), G4(10), P4(10));
ld11: GPcell port map(G3(11), P3(11), G2(3), P2(3), G4(11), P4(11));
ld12: GPcell port map(G3(12), P3(12), G3(4), P3(4), G4(12), P4(12));
ld13: GPcell port map(G3(13), P3(13), G3(5), P3(5), G4(13), P4(13));
ld14: GPcell port map(G3(14), P3(14), G3(6), P3(6), G4(14), P4(14));
ld15: GPcell port map(G3(15), P3(15), G3(7), P3(7), G4(15), P4(15));

-- computing the carry
C(0) <= c0;
cgen1: carryGen port map(gBus(0), pBus(0), c0, C(1));
cgen2: carryGen port map(G1(1), P1(1), c0, C(2));
cgen3: carryGen port map(G2(2), P2(2), c0, C(3));
cgen4: carryGen port map(G2(3), P2(3), c0, C(4));
cgen5: carryGen port map(G3(4), P3(4), c0, C(5));
cgen6: carryGen port map(G3(5), P3(5), c0, C(6));
cgen7: carryGen port map(G3(6), P3(6), c0, C(7));
cgen8: carryGen port map(G3(7), P3(7), c0, C(8));
cgen9: carryGen port map(G4(8), P4(8), c0, C(9));
cgen10: carryGen port map(G4(9), P4(9), c0, C(10));
cgen11: carryGen port map(G4(10), P4(10), c0, C(11));
cgen12: carryGen port map(G4(11), P4(11), c0, C(12));
cgen13: carryGen port map(G4(12), P4(12), c0, C(13));
cgen14: carryGen port map(G4(13), P4(13), c0, C(14));
cgen15: carryGen port map(G4(14), P4(14), c0, C(15));
cgen16: carryGen port map(G4(15), P4(15), c0, C(16));

-- computing the sum
x0: xorgate port map(pBus(0), C(0), S(0));
x1: xorgate port map(pBus(1), C(1), S(1));
x2: xorgate port map(pBus(2), C(2), S(2));
x3: xorgate port map(pBus(3), C(3), S(3));
x4: xorgate port map(pBus(4), C(4), S(4));
x5: xorgate port map(pBus(5), C(5), S(5));
x6: xorgate port map(pBus(6), C(6), S(6));
x7: xorgate port map(pBus(7), C(7), S(7));
x8: xorgate port map(pBus(8), C(8), S(8));
x9: xorgate port map(pBus(9), C(9), S(9));
x10: xorgate port map(pBus(10), C(10), S(10));
x11: xorgate port map(pBus(11), C(11), S(11));
x12: xorgate port map(pBus(12), C(12), S(12));
x13: xorgate port map(pBus(13), C(13), S(13));
x14: xorgate port map(pBus(14), C(14), S(14));
x15: xorgate port map(pBus(15), C(15), S(15));

x16: xorgate port map(ABus(15), BBus(15), m1);
x17: xorgate port map(m1, C(16), m2);
-- enabling the output
Z1: genZ port map(S, m2, e, Z);

E1: enabler port map(S, m2, e, S_e, carry);

-- connecting sum to the output
sum(0) <= S_e(0);
sum(1) <= S_e(1);
sum(2) <= S_e(2);
sum(3) <= S_e(3);
sum(4) <= S_e(4);
sum(5) <= S_e(5);
sum(6) <= S_e(6);
sum(7) <= S_e(7);
sum(8) <= S_e(8);
sum(9) <= S_e(9);
sum(10) <= S_e(10);
sum(11) <= S_e(11);
sum(12) <= S_e(12);
sum(13) <= S_e(13);
sum(14) <= S_e(14);
sum(15) <= S_e(15);
 
end e10;

