----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:46:07 12/15/2014 
-- Design Name: 
-- Module Name:    ej2 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ej2 is
	port(
		clk : in std_logic;
		d : in std_logic;
		o: out std_logic
	);
end ej2;

architecture Behavioral of ej2 is
	type estado is (s0, s1, s2, s3);
	signal est_reg, est_next : estado;
	signal outi : std_logic := '0';
begin
	process( clk )
	begin
		if( clk'event and clk = '1') then
			est_reg <= est_next;
		end if;
	end process;
	process(est_reg, d)
	begin
		est_next <= est_reg;
		case est_reg is
			when s0 =>
				if( d = '1' ) then
					est_next <= s1;
				else
					est_next <= s0;
				end if;
			when s1 =>
				if( d = '1' ) then
					est_next <= s2;
				else
					est_next <= s0;
				end if;
			when s2 =>
				if( d = '1' ) then
					est_next <= s3;
				else
					est_next <= s0;
				end if;
			when s3 =>
				if( d = '1' ) then
					est_next <= s3;
				else
					est_next <= s0;
				end if;
		end case;
	end process;
	o <= not o when (est_reg = s3) else o;
end Behavioral;

