library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.std_logic_1164.all;

--constant one: bit_vector(15 downto 0) := "0000000000000001";

entity complement is
	port(ABus: in bit_vector(15 downto 0);
		  AnotBus: out bit_vector(15 downto 0));
end complement;
architecture e5 of complement is

component notgate
port (a: in bit;
		z: out bit);
end component;

begin 
	x0: notgate port map(ABus(0), AnotBus(0));
	x1: notgate port map(ABus(1), AnotBus(1));
	x2: notgate port map(ABus(2), AnotBus(2));
	x3: notgate port map(ABus(3), AnotBus(3));
	x4: notgate port map(ABus(4), AnotBus(4));
	x5: notgate port map(ABus(5), AnotBus(5));
	x6: notgate port map(ABus(6), AnotBus(6));
	x7: notgate port map(ABus(7), AnotBus(7));
	x8: notgate port map(ABus(8), AnotBus(8));
	x9: notgate port map(ABus(9), AnotBus(9));
	x10: notgate port map(ABus(10), AnotBus(10));
	x11: notgate port map(ABus(11), AnotBus(11));
	x12: notgate port map(ABus(12), AnotBus(12));
	x13: notgate port map(ABus(13), AnotBus(13));
	x14: notgate port map(ABus(14), AnotBus(14));
	x15: notgate port map(ABus(15), AnotBus(15));
end architecture;


entity subtractor is
port(ABus: in bit_vector(15 downto 0);
	  BBus: in bit_vector(15 downto 0);
	  e: in bit;
	  carry: out bit;
	  z: out bit;
	  CBus: out bit_vector(15 downto 0));
	  
end entity;

architecture s of subtractor is

component complement
port(ABus: in bit_vector(15 downto 0);
	  AnotBus: out bit_vector(15 downto 0));		
end component;

component PrefixAdder
	port(ABus: in bit_vector(15 downto 0);  
		  BBus: in bit_vector(15 downto 0);  
		  c0: in bit;                        
		  e: in bit;                        
	     carry: out bit;	                   
		  Z: out bit;
		  Sum: out bit_vector(15 downto 0)); -- sum vector output port
end component;

signal A2Bus: bit_vector(15 downto 0);

begin
s: complement port map(BBus, A2Bus);
o: PrefixAdder port map(ABus, A2Bus, '1', e, carry, z, CBus);
end s;