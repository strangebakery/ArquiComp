library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is
	port (	entr0, entr1 : in signed(15 downto 0);
			saida : out signed(15 downto 0);
			op_sel : in unsigned(1 downto 0);
			overflow, zero : out std_logic
	);
end entity;

architecture a_ULA of ULA is
	component mux_4x1
			port (	entr0, entr1, entr2, entr3 : in signed(15 downto 0);
					sel : in unsigned(1 downto 0);
					saida : out signed(15 downto 0)
			);
	end component;
	
signal soma : signed(16 downto 0); -- sinal de (16+1) bits, usado para previnir erro de overflow da soma
signal subtr, moi, neg : signed(15 downto 0); -- moi := menor ou igual

begin
		
	soma <= (entr0(15)&entr0) + (entr1(15)&entr1); --cria dois valores temporarios usando os MSBs dos valores para preservar os sinais (matermaticos) dos operandos...
	overflow <= soma(16);
	
	subtr <= entr0 - entr1;
	
	moi <= "0000000000000001" when entr0 <= entr1 else
			 "0000000000000000";
			
	neg <= "0000000000000001" when (soma < 0 or subtr < 0) else
			 "0000000000000000";
	
	zero <= '1' when (soma = 0 or subtr = 0) else
		'0';
			 
	M1: mux_4x1 port map (	entr0 => soma(15 downto 0),
							entr1 => subtr(15 downto 0),
							entr2 => moi,
							entr3 => neg,
							sel => op_sel,
							saida => saida); --mapeia as portas da ULA com as operacoes atraves do MUX
			 
end architecture;