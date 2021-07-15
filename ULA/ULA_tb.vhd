library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end entity;

architecture a_ULA_tb of ULA_tb is
	component ULA
		port (	entr0, entr1 : in signed(15 downto 0);
				saida : out signed(15 downto 0);
				op_sel : in unsigned(1 downto 0);
				overflow, zero : out std_logic
		);
	end component;
	signal overflow, zero : std_logic;
	signal entr0, entr1, saida : signed(15 downto 0);
	signal op_sel : unsigned(1 downto 0);
begin
	UUT: ULA port map (	entr0 => entr0,
						entr1 => entr1,
						saida => saida,
						op_sel => op_sel,
						overflow => overflow,
						zero => zero);
	process
	begin
		--SOMA
		--caso trivial, sem overflow
		entr0 <= "0000000000000001";
		entr1 <= "0000000000000010";
		op_sel <= "00";
		wait for 50 ns;
		--caso trivial, com overflow
		entr0 <= "0100000000000001";
		entr1 <= "0100000000000010";
		op_sel <= "00";
		wait for 50 ns;
		--mais uma op de soma, sem overflow
		entr0 <= "0001000000000001";
		entr1 <= "0101100000000011";
		op_sel <= "00";
		wait for 50 ns;
		--mais uma op de soma, com overflow
		entr0 <= "0101001000100011";
		entr1 <= "0111000110000010";
		op_sel <= "00";
		wait for 50 ns;
		--soma com segundo valor negativo
		entr0 <= "0101001000100011";
		entr1 <= "1111000110000010";
		op_sel <= "00";
		wait for 50 ns;
		--soma com primeiro valor negativo
		entr0 <= "1101001000100011";
		entr1 <= "0111000110000010";
		op_sel <= "00";
		wait for 50 ns;
		--soma com ambos valores negativos
		entr0 <= "1101001000100011";
		entr1 <= "1111000110000010";
		op_sel <= "00";
		wait for 50 ns;
		--SUBTRACAO
		--caso trivial
		entr0 <= "1111111111111101";
		entr1 <= "1111111111111110";
		op_sel <= "01";
		wait for 50 ns;
		
		entr0 <= "1010101011111101";
		entr1 <= "1101010100111110";
		op_sel <= "01";
		wait for 50 ns;
		wait;
	end process;
end architecture;