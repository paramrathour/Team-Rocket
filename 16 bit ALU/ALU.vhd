library ieee;
use ieee.std_logic_1164.all;

--An ALU that performs
--1) Signed Addition (00)
--2) Subtraction (01)
--3) Bitwise NAND (10)
--4) Bitwise XOR (11)
entity ALU is 
	port(A, B: in bit_vector(15 downto 0);   --16 bit inputs
		  S1, S0: in bit;                     --select inputs
		  R: out bit_vector(15 downto 0);     --16 bit result
		  Z, C: out bit);                     --zero and carry bits
end ALU; 

architecture arc of ALU is
-- using a decoder to enable the correct block using the select input
component Decoder2to4
	port( A0, A1: in bit;
	      D0, D1, D2, D3: out bit);
end component;
-- Kogge-Stone implementation of a signed prefix adder
component PrefixAdder
	port(ABus: in bit_vector(15 downto 0);  
		  BBus: in bit_vector(15 downto 0);  
		  c0: in bit;                        
		  e: in bit;                         
	     carry: out bit;	                   
		  Z: out bit;
		  Sum: out bit_vector(15 downto 0)); 
end component;
-- subtractor block
component subtractor
	port(ABus: in bit_vector(15 downto 0);
		BBus: in bit_vector(15 downto 0);
		e: in bit;
		carry: out bit;
		z: out bit;
		CBus: out bit_vector(15 downto 0));
end component;
-- 16 bit NAND block
component nand_16
	port(Abus: in bit_vector(15 downto 0);
	  Bbus: in bit_vector(15 downto 0);
	  en: in bit;
	  Cbus_en: out bit_vector(15 downto 0);
	  Z:out bit);
end component;
-- 16 bit XOR block
component xor_16
	port(Abus: in bit_vector(15 downto 0);
	  Bbus: in bit_vector(15 downto 0);
	  en: in bit;
	  Cbus_en: out bit_vector(15 downto 0);
	  Z:out bit);
end component;
-- block to 'OR' results of adder, subtractor, NAND, XOR blocks
component BigOR
port(AddBus: in bit_vector(15 downto 0);      --output from adder
		  Z_a, C_a: in bit;                     --zero and carry from adder
		  SubBus: in bit_vector(15 downto 0);   --output from subtractor
		  Z_s, C_s: in bit;                     --zero and carry from subtractor
		  NandBus: in bit_vector(15 downto 0);  --output of nand
		  Z_nan: in bit;                        --zero of nand
		  XorBus: in bit_vector(15 downto 0);   --output of xor
		  Z_xor: in bit;                        --zero of xor
		  Z_out: out bit;                       --zero output
		  C_out: out bit;                       --carry output
		  R_out: out bit_vector(15 downto 0));  --result
end component;
signal x0, x1, x2, x3: bit;                   --outputs of the decoder
signal R_a, R_s, R_n, R_x: bit_vector(15 downto 0); --results of the adder, subtractor, NAND, XOR blocks
signal C_a, C_s, Z_a, Z_s, Z_n, Z_x: bit;     --carrys and zeroes of adder, subtractor, NAND, XOR blocks 
begin 

decoder: Decoder2to4 port map(S0, S1, x0, x1, x2, x3);

adder: PrefixAdder port map(A, B, '0', x0, C_a, Z_a, R_a);

sub: subtractor port map(A, B, x1, C_s, Z_s, R_s);

nander: nand_16 port map(A, B, x2, R_n, Z_n);

xorer: xor_16 port map(A, B, x3, R_x, Z_x);

finalor: BigOR port map(R_a, Z_a, C_a, R_s, Z_s, C_s, R_n, Z_n, R_x, Z_x, Z, C, R); 
end arc;	  