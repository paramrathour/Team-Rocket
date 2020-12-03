entity ALUTB is
end ALUTB;

architecture ALUtestbench of ALUTB is
	component ALU is
	port(A, B: in bit_vector(15 downto 0);
	  	 S0, S1: in bit;
	     R: out bit_vector(15 downto 0);
	     Z, C: out bit);
	end component;
	signal A_test, B_test: bit_vector(15 downto 0);
	signal S0_test, S1_test: bit;
	signal R_test: bit_vector(15 downto 0);
	signal Z_test, C_test: bit;
	
begin 
	ALUdut_instance: ALU
		port map(A=>A_test, B=>B_test, S0=>S0_test, S1=>S1_test, R=>R_test, C=>C_test, Z=>Z_test);
		
	process 
	begin	

------------------------------- Signed Addition ----------------------------------
		A_test<= "0000000000000000"; B_test<="0000000000000000"; S0_test<='0'; S1_test<='0';
		wait for 5 ns;

		A_test<= "0000000000000001"; B_test<="1111111111111111"; S0_test<='0'; S1_test<='0';
		wait for 5 ns;

		A_test<= "0000000000001000"; B_test<="0001000000000000"; S0_test<='0'; S1_test<='0';
		wait for 5 ns;

		A_test<= "1011101101110110"; B_test<="0100010010001001"; S0_test<='0'; S1_test<='0'; -- 47990 + 17545
		wait for 5 ns;

		A_test<= "1001100000010101"; B_test<="0100100111000110"; S0_test<='0'; S1_test<='0'; -- 38933 + 18886
		wait for 5 ns;

		A_test<= "1010010100010100"; B_test<="1100011101100111"; S0_test<='0'; S1_test<='0'; -- 42260 + 51047
		wait for 5 ns;

----------------------------  Subtraction ----------------------------------------
		A_test<= "0000000000000000"; B_test<="0000000000000000"; S0_test<='1'; S1_test<='0';
		wait for 5 ns;

		A_test<= "0000000000000001"; B_test<="1111111111111111"; S0_test<='1'; S1_test<='0';
		wait for 5 ns;

		A_test<= "0000000000001000"; B_test<="0001000000000000"; S0_test<='1'; S1_test<='0';
		wait for 5 ns;

		A_test<= "1011101101110110"; B_test<="0100010010001001"; S0_test<='1'; S1_test<='0'; -- 47990 - 17545
		wait for 5 ns;

		A_test<= "1001100000010101"; B_test<="0100100111000110"; S0_test<='1'; S1_test<='0'; -- 38933 - 18886
		wait for 5 ns;

		A_test<= "1010010100010100"; B_test<="1100011101100111"; S0_test<='1'; S1_test<='0'; -- 42260 - 51047
		wait for 5 ns;

------------------------------------ NAND ----------------------------------------
		A_test<= "0000000000000000"; B_test<="0000000000000000"; S0_test<='0'; S1_test<='1';
		wait for 5 ns;

		A_test<= "0000000000000001"; B_test<="1111111111111111"; S0_test<='0'; S1_test<='1';
		wait for 5 ns;

		A_test<= "0000000000001000"; B_test<="0001000000000000"; S0_test<='0'; S1_test<='1';
		wait for 5 ns;

		A_test<= "1011101101110110"; B_test<="0100010010001001"; S0_test<='0'; S1_test<='1'; -- 47990 NAND 17545
		wait for 5 ns;

		A_test<= "1001100000010101"; B_test<="0100100111000110"; S0_test<='0'; S1_test<='1'; -- 38933 NAND 18886
		wait for 5 ns;

		A_test<= "1010010100010100"; B_test<="1100011101100111"; S0_test<='0'; S1_test<='1'; -- 42260 NAND 51047
		wait for 5 ns;

----------------------------------- XOR ------------------------------------------
		A_test<= "0000000000000000"; B_test<="0000000000000000"; S0_test<='1'; S1_test<='1';
		wait for 5 ns;

		A_test<= "0000000000000000"; B_test<="1111111111111111"; S0_test<='1'; S1_test<='1';
		wait for 5 ns;

		A_test<= "0000000000001000"; B_test<="0001000000000000"; S0_test<='1'; S1_test<='1';
		wait for 5 ns;

		A_test<= "1011101101110110"; B_test<="0100010010001001"; S0_test<='1'; S1_test<='1'; -- 47990 XOR 17545
		wait for 5 ns;

		A_test<= "1001100000010101"; B_test<="0100100111000110"; S0_test<='1'; S1_test<='1'; -- 38933 XOR 18886
		wait for 5 ns;

		A_test<= "1010010100010100"; B_test<="1100011101100111"; S0_test<='1'; S1_test<='1'; -- 42260 XOR 51047
		wait for 5 ns;

	end process;
end ALUtestbench;