library ieee;
use ieee.std_logic_1164.all;

-- Definition of 2 input AND operator --
entity mandgate is
port(a, b: in bit;
     z: out bit);
end mandgate;
architecture andbehaviour of mandgate is
begin
z <= a AND b;
end andbehaviour;

-- Definition of NOT operator --
entity mnotgate is
port(a: in bit;
     z: out bit);
end mnotgate;
architecture notbehaviour of mnotgate is
begin
z <= NOT a;
end notbehaviour;
--
---- Definition of 2 to 4 line Decoder operator --
entity Decoder2to4 is
	port( A0, A1: in bit;
	      D0, D1, D2, D3: out bit);
end entity Decoder2to4;

architecture Decoder2to4behaviour of Decoder2to4 is

	component mandgate is                            -- Defined in entity named ANDgate
	port(a, b: in bit; 
	     z: out bit);
	end component;

	component mnotgate is                            -- Defined in entity named NOTgate
	port(a: in bit;
	     z: out bit);
	end component;
                                                   
	signal P0, P1: bit;                             -- P0 is notA0, P1 is notA1, Di is ith output of Decoder
    
   -- D0 for Signed Addition (notA0 AND notA1)																	
   -- D1 for Subtraction     (A0 AND notA1)
   -- D2 for NAND            (notA0 AND A1)
   -- D3 for XOR             (A0 AND A1)
	
begin

	M1 : mnotgate
	port map (A0, P0);
	M2 : mnotgate
	port map (A1, P1);
	N1 : mandgate
	port map (P0, P1, D0);
	N2 : mandgate
	port map (A0, P1, D1);
	N3 : mandgate
	port map (P0, A1, D2);
	N4 : mandgate
	port map (A0, A1, D3);
			
end Decoder2to4behaviour;