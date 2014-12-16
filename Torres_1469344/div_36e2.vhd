----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:04:15 12/15/2014 
-- Design Name: 
-- Module Name:    div_36e2 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity div_36e2 is
	port(
		clk_en : in std_logic;
		syn_clr : in std_logic;
		clk : in std_logic;
		tick_out: out std_logic
	);
end div_36e2;

architecture Behavioral of div_36e2 is
	signal cont_reg, cont_next : unsigned(11 downto 0); -- Para hacer la cuenta hasta 3600
	signal timeout_u : unsigned(11 downto 0); -- Para ver si llega al valor
	type estado is (clear, count); -- Estados para el reset que se debe activar 1 ciclo despues de ser recibido
	signal est_reg, est_next : estado;
begin
	process( clk ) -- Proceso de cambio de estado y de modificacion del contador
	begin
		if( clk'event and clk = '1' and clk_en = '1' ) then
			est_reg <= est_next;
			cont_reg <= cont_next;
		end if;
	end process;
	process(est_reg, syn_clr)
	begin
		est_next <= est_reg;
		case est_reg is
			when clear => 
				if( syn_clr = '0' ) then
					est_next <= count;
				end if;
			when count =>
				if( syn_clr = '1' ) then
					est_next <= clear;
				end if;
		end case;
	end process;
	cont_next <= cont_reg + 1 when ( cont_reg < timeout_u and est_reg=count ) else
					 ( others => '0' );
					 
	tick_out <= '1' when ( cont_reg = timeout_u ) else
			  '0';
			  
	timeout_u <= to_unsigned( 3600, 12 );

end Behavioral;

