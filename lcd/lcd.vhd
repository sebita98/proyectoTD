----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:24:45 11/22/2014 
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lcd is
	port(
		clr : in	std_logic;
		clk : in	std_logic;
		start : in		std_logic;
		data_in : in	std_logic_vector(3 downto 0);
		rs : in			std_logic;
		lcd_data : out	std_logic_vector(3 downto 0);
		lcd_rs : out	std_logic;
		lcd_e : out		std_logic;
		lcd_tick : out	std_logic
	);
end entity lcd;

architecture fsmd of lcd is
	type estado is ( reposo, lcd_1, lcd_2, lcd_3, fin );
	signal est_reg, est_next : estado;
	
	signal lcd_time : std_logic_vector(19 downto 0);
	
	signal tmr_clr : std_logic;
	signal tmr_tick : std_logic;
begin
	process( clr, clk )
	begin
		if( clr = '1' ) then
			est_reg <= reposo;
		elsif( clk'event and clk = '1' ) then
			est_reg <= est_next;
		end if;
	end process;
	
	process(est_reg, start, tmr_tick)
	begin
		est_next <= est_reg;
		
		case est_reg is
			when reposo =>
				if( start = '1' ) then
					est_next <= lcd_1;
				end if;
			when lcd_1 =>
				if( tmr_tick = '1' ) then
					est_next <= lcd_2;
				end if;
			when lcd_2 =>
				if( tmr_tick = '1' ) then
					est_next <= lcd_3;
				end if;				
			when lcd_3 =>
				if( tmr_tick = '1' ) then
					est_next <= fin;
				end if;				
			when fin =>
				est_next <= reposo;
			when others =>
		end case;
	end process;
	
	tmr_unit : entity work.timer
		port map(
			clr => clr,
			clk => clk,
			sclr => tmr_clr,
			timeout => lcd_time,
			tick => tmr_tick
		);
		
	lcd_time <= std_logic_vector( to_unsigned( 5000, 20 ) ) when ( rs = '1' ) else
					std_logic_vector( to_unsigned( 500000, 20 ) );
					
	
	lcd_data <= data_in;
	lcd_rs <= rs;
	lcd_e <= '1' when ( est_reg = lcd_2 ) else
				'0';
	
	lcd_tick <= '1' when ( est_reg = fin ) else
					'0';
					
	tmr_clr <= '1' when ( est_reg = reposo ) else
				  '1' when ( est_reg = fin ) else
				  '0';
end architecture fsmd;