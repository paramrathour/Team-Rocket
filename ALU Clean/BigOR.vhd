library ieee;
use ieee.std_logic_1164.all;

--defining a 4 input or gate
entity or4gate is
port(a, b, c, d: in bit;
     z: out bit);
end or4gate;
architecture e1 of or4gate is
begin
z <= (a or b or c or d);
end e1;


---- defining an or gate
--entity orgate is
--port(a, b: in bit;
--     z: out bit);
--end orgate;
--architecture e2 of orgate is
--begin
--z <= a or b;
--end e2;

--BigOR block
entity BigOR is
	port(AddBus: in bit_vector(15 downto 0);   --output from adder
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
end BigOR;

architecture e3 of BigOR is
component or4gate
port(a, b, c, d: in bit;
     z: out bit);
end component;
component orgate
port(a, b: in bit;
     z: out bit);
end component;
begin
o1: orgate port map(C_a, C_s, C_out);

or4_0: or4gate port map(AddBus(0), SubBus(0), NandBus(0), XorBus(0), R_out(0));
or4_1: or4gate port map(AddBus(1), SubBus(1), NandBus(1), XorBus(1), R_out(1));
or4_2: or4gate port map(AddBus(2), SubBus(2), NandBus(2), XorBus(2), R_out(2));
or4_3: or4gate port map(AddBus(3), SubBus(3), NandBus(3), XorBus(3), R_out(3));
or4_4: or4gate port map(AddBus(4), SubBus(4), NandBus(4), XorBus(4), R_out(4));
or4_5: or4gate port map(AddBus(5), SubBus(5), NandBus(5), XorBus(5), R_out(5));
or4_6: or4gate port map(AddBus(6), SubBus(6), NandBus(6), XorBus(6), R_out(6));
or4_7: or4gate port map(AddBus(7), SubBus(7), NandBus(7), XorBus(7), R_out(7));
or4_8: or4gate port map(AddBus(8), SubBus(8), NandBus(8), XorBus(8), R_out(8));
or4_9: or4gate port map(AddBus(9), SubBus(9), NandBus(9), XorBus(9), R_out(9));
or4_10: or4gate port map(AddBus(10), SubBus(10), NandBus(10), XorBus(10), R_out(10));
or4_11: or4gate port map(AddBus(11), SubBus(11), NandBus(11), XorBus(11), R_out(11));
or4_12: or4gate port map(AddBus(12), SubBus(12), NandBus(12), XorBus(12), R_out(12));
or4_13: or4gate port map(AddBus(13), SubBus(13), NandBus(13), XorBus(13), R_out(13));
or4_14: or4gate port map(AddBus(14), SubBus(14), NandBus(14), XorBus(14), R_out(14));
or4_15: or4gate port map(AddBus(15), SubBus(15), NandBus(15), XorBus(15), R_out(15));

or4_16: or4gate port map(Z_a, Z_s, Z_nan, Z_xor, Z_out);

end e3;