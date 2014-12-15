----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:30:28 11/22/2014 
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
use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lcd_top is
	port(
		clr : in	std_logic;
		clk : in	std_logic;
		lcd_rs : out	std_logic;
		lcd_e : out		std_logic;
		lcd_data : out	std_logic_vector(3 downto 0)
--		but1 : in std_logic;
--		but2 : in std_logic;
--		but3 : in std_logic;
--		but4 : in std_logic
	);
end entity lcd_top;


architecture fsm of lcd_top is
	type estado is ( inicio, cmd_1, wait_1, cmd_2, wait_2,cmd_3, wait_3,
							cmd_4, wait_4, cmd_5, wait_5, texto, wait_texto, texto_inc, fin );
	signal est_reg, est_next : estado;

	
	signal char_reg, char_next : unsigned(2 downto 0);
	
	signal dato_ascii : std_logic_vector(3 downto 0);
	
	signal lcd_start : std_logic;
	signal lcd_rs_in : std_logic;
	signal lcd_data_in : std_logic_vector(3 downto 0);
	signal lcd_tick : std_logic;
	signal tmr_tick : std_logic;
begin
	process( clr, clk )
	begin
		if( clr = '1' ) then
			est_reg <= inicio;
		elsif( clk'event and clk = '1' ) then
			est_reg <= est_next;
		end if;
	end process;
	
	process( clr, clk )
	begin
		if( clr = '1' ) then
			char_reg <= ( others => '0' );
		elsif( clk'event and clk = '1' ) then
			char_reg <= char_next;
		end if;
	end process;
	
	process(est_reg, lcd_tick,char_reg)
	begin
		est_next <= est_reg;
		
		case est_reg is
			when inicio =>
				est_next <= cmd_1;
			when cmd_1 =>
				est_next <= wait_1;
			when wait_1 =>
				if( lcd_tick = '1' ) then
					est_next <= cmd_2;
				end if;
			when cmd_2 =>
				est_next <= wait_2;
			when wait_2 =>
				if( lcd_tick = '1' ) then
					est_next <= cmd_3;
				end if;				
			when cmd_3 =>
				est_next <= wait_3;
			when wait_3 =>
				if( lcd_tick = '1' ) then
					est_next <= cmd_4;
				end if;				
			when cmd_4 =>
				est_next <= wait_4;
			when wait_4 =>
				if( lcd_tick = '1' ) then
					est_next <= cmd_5;
				end if;								
			when cmd_5 =>
				est_next <= wait_5;
			when wait_5 =>
				if( lcd_tick = '1' ) then
					est_next <= texto;
				end if;				
			when texto =>
				est_next <= wait_texto;
			when wait_texto =>
				if( lcd_tick = '1' ) then
					est_next <= texto_inc;
				end if;							
			when texto_inc =>
				if( char_reg = 4 ) then
					est_next <= fin;
				else
					est_next <= texto;
				end if;			
			when fin =>
			when others =>
		end case;
	end process;
	
	lcd_unit : entity work.lcd
		port map(
			clr => clr,
			clk => clk,
			start => lcd_start,
			data_in => lcd_data_in,
			rs => lcd_rs_in,
			lcd_data => lcd_data,
			lcd_rs => lcd_rs,
			lcd_e => lcd_e,
			lcd_tick => lcd_tick
		);
		
	txt_unit : entity	work.rom
		port map(
			addr => std_logic_vector(char_reg(1 downto 0)),
			dato => dato_ascii
		);
		
	lcd_data_in <= "0000" when ( est_reg = cmd_1 or est_reg = wait_1 ) else
					"0001" when ( est_reg = cmd_2 or est_reg = wait_2 ) else
					"0000" when ( est_reg = cmd_3 or est_reg = wait_3 ) else
					"0000" when ( est_reg = cmd_4 or est_reg = wait_4 ) else
					"0000" when ( est_reg = cmd_5 or est_reg = wait_5 ) else
					dato_ascii when ( est_reg = texto or est_reg = wait_texto ) else
					( others => '0' );
					
	lcd_rs_in	<= '1'when ( est_reg = texto or est_reg = wait_texto ) else
						'0';
	
	lcd_start <= '1' when ( est_reg = cmd_1 ) else
					 '1' when ( est_reg = cmd_2 ) else
					 '1' when ( est_reg = cmd_3 ) else
					 '1' when ( est_reg = cmd_4 ) else
					 '1' when ( est_reg = cmd_5 ) else
					 '1' when ( est_reg = texto ) else
					 '0';
	
	
	char_next <= ( others => '0' ) when ( est_reg = wait_5 ) else
					 char_reg + 1 when ( est_reg = texto_inc ) else
					 char_reg;
--	bot1: entity work.debounce(logic)
--			port map(clk => clk, button =>but1,result=>but1out);
end architecture fsm;