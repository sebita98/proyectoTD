----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:01:08 12/14/2014 
-- Design Name: 
-- Module Name:    lcd_top - Behavioral 
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

entity lcd_top is
	port(
		clr : in	std_logic;
		clk : in	std_logic;
		start : in		std_logic;
		lcd_data : out	std_logic_vector(3 downto 0);
		lcd_rs : out	std_logic;
		lcd_rw : out	std_logic;
		lcd_e : out		std_logic
	);
end lcd_top;

architecture Behavioral of lcd_top is
	type estado is ( reposo, wait_start, lcd_set, lcd_entry, lcd_on, lcd_clear, wait_clear, waitText);
	signal est_reg, est_next : estado;
	signal lcd_tick: std_logic;
	signal tick: std_logic;
	signal wait_time: std_logic_vector(19 downto 0);
	signal tmr_clr: std_logic;
	signal lcd_data_in : std_logic_vector(7 downto 0);
begin
	nextEst:process( clr, clk )
	begin
		if( clr = '1' ) then
			est_reg <= reposo;
		elsif( clk'event and clk = '1' ) then
			est_reg <= est_next;
		end if;
	end process;
	process(est_reg, start, lcd_tick, tick)
	begin
		est_next <= est_reg;
		case est_reg is
			when reposo => 
				if( start = '1' ) then
					est_next <= wait_start;
				end if;
			when wait_start =>
				if(lcd_tick = '1') then
					est_next <= lcd_set;
				end if;
			when lcd_set =>
				if(lcd_tick = '1') then
					est_next <= lcd_entry;
				end if;
			when lcd_entry =>
				if(lcd_tick = '1') then
					est_next <= lcd_on;
				end if;
			when lcd_on =>
				if(lcd_tick = '1') then
					est_next <= lcd_clear;
				end if;
			when lcd_clear =>
				if(lcd_tick = '1') then
					est_next <= wait_clear;
				end if;
			when wait_clear =>
				if(tick = '1') then
					est_next <= waitText;
				end if;
			when waitText =>
					est_next <= waitText;
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
	lcd_unit : entity work.lcd
		port map(
			clr => clr,
			clk => clk,
			start => start,
			lcd_tick => lcd_tick,
			lcd_data_in => lcd_data_in,
			lcd_data => lcd_data,
			lcd_rw => lcd_rw,
			lcd_e => lcd_e
		);
		lcd_data_in <= "00101000" when( est_reg = lcd_set ) else
							"00000110" when( est_reg = lcd_entry ) else
							"00001100" when( est_reg = lcd_on ) else
							"00000001" when( est_reg = lcd_clear ) else
							(others => '0');
		lcd_rs <= '1' when(est_reg=waitText) else '0';
		wait_time <= std_logic_vector( to_unsigned( 82000, 20 ) ) when ( est_reg=wait_clear ) else
						(others => '0');

end Behavioral;

