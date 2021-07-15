library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_4x1 is
	port (	entr0, entr1, entr2, entr3 : in signed(15 downto 0);
			sel : in unsigned(1 downto 0);
			saida : out signed(15 downto 0)
	);
end entity;

architecture a_mux_4x1 of mux_4x1 is
begin
	saida <= entr0 when sel="00" else
			 entr1 when sel="01" else
			 entr2 when sel="10" else
			 entr3 when sel="11" else
			 "0000000000000000";
end architecture;