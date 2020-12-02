library ieee;
use ieee.std_logic_1164.all;

-- Definition of 2 input AND operator --
entity ANDgate is
port(a, b: in bit;
     z: out bit);
end ANDgate;
architecture ANDbehaviour of ANDgate is
begin
z <= a AND b;
end ANDbehaviour;

-- Definition of NOT operator --
entity NOTgate is
port(a: in bit;
     z: out bit);
end NOTgate;
architecture NOTbehaviour of NOTgate is
begin
z <= NOT a;
end NOTbehaviour;

-- Definition of 2 to 4 line Decoder operator --
entity Decoder2to4 is
	port( A0, A1: in bit;
	      D0, D1, D2, D3: out bit);
end entity Decoder2to4;

architecture Decoder2to4behaviour of Decoder2to4 is

	component ANDgate is                            -- Defined in entity named ANDgate
	port(a, b: in bit; 
	     z: out bit);
	end component;

	component NOTgate is                            -- Defined in entity named NOTgate
	port(a: in bit;
	     z: out bit);
	end component;
                                                   
	signal P0, P1: bit;                             -- P0 is notA0, P1 is notA1, Di is ith output of Decoder
    
   -- D0 for Signed Addition (notA0 AND notA1)																	
   -- D1 for Subtraction     (A0 AND notA1)
   -- D2 for NAND            (notA0 AND A1)
   -- D3 for XOR             (A0 AND A1)
	
begin

	M1 : NOTgate
	port map (A0, P0);
	M2 : NOTgate
	port map (A1, P1);
	N1 : ANDgate
	port map (P0, P1, D0);
	N2 : ANDgate
	port map (A0, P1, D1);
	N3 : ANDgate
	port map (P0, A1, D2);
	N4 : ANDgate
	port map (A0, A1, D3);
			
end Decoder2to4behaviour;	