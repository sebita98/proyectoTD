----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:45:38 12/14/2014 
-- Design Name: 
-- Module Name:    lcd - Behavioral 
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

entity lcd is
	port(
		clr : in	std_logic;
		clk : in	std_logic;
		start : in		std_logic;
		lcd_data_in : in std_logic_vector(7 downto 0);
		lcd_data : out	std_logic_vector(3 downto 0);
		lcd_rw : out	std_logic;
		lcd_e : out		std_logic;
		lcd_tick : out std_logic
	);
end lcd;

architecture Behavioral of lcd is
	type estado is ( reposo, wait_start, cmd1, wait1, cmd2, wait2, cmd3, wait3, waitComm, cmd4, wait4, setUpper, waitEnUpper, waitEnLower, waitToNext, setLower, setWait );
	signal est_reg, est_next : estado;
	signal tick: std_logic;
	signal wait_time: std_logic_vector(19 downto 0);
	signal tmr_clr: std_logic;
begin
	nextEst:process( clr, clk )
	begin
		if( clr = '1' ) then
			est_reg <= reposo;
		elsif( clk'event and clk = '1' ) then
			est_reg <= est_next;
		end if;
	end process;
	process(est_reg, start, tick, lcd_data_in)
	begin
		est_next <= est_reg;
		case est_reg is
			when reposo => 
				if( start = '1' ) then
					est_next <= wait_start;
				end if;
			when wait_start =>	-- 150ms
				if( tick = '1' ) then
					est_next <= cmd1;
				end if;
			when cmd1 =>			-- 12 ciclos
				if( tick = '1' ) then
					est_next <= wait1;
				end if;
			when wait1 =>			-- 4.1ms
				if( tick = '1' ) then
					est_next <= cmd2;
				end if;
			when cmd2 =>			-- 12 ciclos
				if( tick = '1' ) then
					est_next <= wait2;
				end if;
			when wait2 =>			-- 100us
				if( tick = '1' ) then
					est_next <= cmd3;
				end if;
			when cmd3 =>			-- 12 ciclos
				if( tick = '1' ) then
					est_next <= wait3;
				end if;
			when wait3 =>			-- 40us
				if( tick = '1' ) then
					est_next <= cmd4;
				end if;
			when cmd4 =>			-- 12 ciclos
				if( tick = '1' ) then
					est_next <= wait4;
				end if;
			when wait4 => 			--40us
				if( tick = '1' ) then
					est_next <= waitComm;
				end if;
				
			-- ACA SE TERMINO LA CONFIGURACION INICIAL DEL LCD
		
			when waitComm =>		--Espero que me llegue un comando
				if	(lcd_data_in /= "00000000") then
					est_next <= setUpper;
				end if;
			when setUpper =>		--Pongo el upper por 12 ciclos
				if( tick = '1' ) then
					est_next <= waitEnUpper;
				end if;
			when waitEnUpper =>	--20ns Para que despues cambien los otros valores
				if( tick = '1' ) then
					est_next <= setWait;
				end if;
			when setWait =>		-- 1us
				if( tick = '1' ) then
					est_next <= setLower;
				end if;
			when setLower =>		--Pongo el lower por 12 ciclos
				if( tick = '1' ) then
					est_next <= waitEnLower;
				end if;
			when waitEnLower =>	--20ns Para que despues cambien los otros valores
				if( tick = '1' ) then
					est_next <= waitToNext;
				end if;
			when waitToNext =>	-- 40us
				if( tick = '1' ) then
					est_next <= waitComm;
				end if;
		end case;
	end process;
	tmr_unit : entity work.timer
		port map(
			clr => clr,
			clk => clk,
			sclr => tmr_clr,
			timeout => wait_time,
			tick => tick
		);
	lcd_rw <= '0';
	lcd_e <= '1' when (est_reg=cmd1 or est_reg=cmd2 or est_reg=cmd3 or est_reg=cmd4 or est_reg=setUpper or est_reg=setLower) else '0';
	lcd_tick <= '1' when (est_reg=waitComm) else '0';
	
	wait_time <= std_logic_vector( to_unsigned( 750000, 20 ) ) when ( est_reg=wait_start ) else
					 std_logic_vector( to_unsigned( 12, 20 ) ) when ( est_reg=cmd1 or est_reg=cmd2 or est_reg=cmd3 or est_reg=cmd3 or est_reg=setLower or est_reg=setUpper) else
					 std_logic_vector( to_unsigned( 205000, 20 ) ) when ( est_reg=wait1 ) else
					 std_logic_vector( to_unsigned( 5000, 20 ) ) when ( est_reg=wait2 ) else
					 std_logic_vector( to_unsigned( 2000, 20 ) ) when ( est_reg=wait3 or est_reg=wait4 or est_reg=waitToNext) else
					 std_logic_vector( to_unsigned( 50, 20 ) ) when ( est_reg=setWait) else
					 std_logic_vector( to_unsigned( 1, 20 ) ) when ( est_reg=waitEnUpper or est_reg=waitEnLower ) else
					( others => '0' );
	
	tmr_clr <= '1' when ( est_reg = reposo ) else
				  '0';
	lcd_data <= "0011" when (est_reg=cmd1 or est_reg=cmd2 or est_reg=cmd3) else
					"0010" when (est_reg=cmd4) else
					"1111" when (est_reg=setUpper or est_reg=waitEnUpper) else
					"1111" when (est_reg=setLower or est_reg=waitEnLower) else
					(others => '0');
end Behavioral;

