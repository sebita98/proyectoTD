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
		lcd_e : out		std_logic;
		btn1 : in std_logic;
		btn2 : in std_logic;
		btn3 : in std_logic;
		btn4 : in std_logic
	);
end lcd_top;

architecture Behavioral of lcd_top is
	type estado is ( reposo, wait_start, lcd_set, lcd_entry, lcd_on, lcd_clear, wait_clear, waitText, sendText);
	signal est_reg, est_next : estado;
	type estadoBut is ( none, sBut0, sBut1, sBut2, sBut3, sendTick );
	signal est_but, est_but_next : estadoBut;
	signal lcd_tick: std_logic;
	signal tick: std_logic;
	signal wait_time: std_logic_vector(19 downto 0);
	signal tmr_clr: std_logic;
	signal lcd_data_in : std_logic_vector(7 downto 0);
	signal button1 : std_logic;
	signal button2 : std_logic;
	signal button3 : std_logic;
	signal button4 : std_logic;
	signal romAddr : std_logic_vector (1 downto 0);
	signal ascii : std_logic_vector(7 downto 0);
	signal dataUp : std_logic;
begin
	nextEst:process( clr, clk )
	begin
		if( clr = '1' ) then
			est_reg <= reposo;
		elsif( clk'event and clk = '1' ) then
			est_reg <= est_next;
			est_but <= est_but_next;
		end if;
	end process;
	process(est_reg, start, lcd_tick, tick, dataUp)
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
				if(dataUp = '1') then
					est_next <= sendText;
				end if;
			when sendText =>
				if(lcd_tick = '1') then
					est_next <= waitText;
				end if;
		end case;
	end process;
	process(est_but, button1, button2, button3, button4, lcd_tick)
	begin
		est_but_next <= est_but;
		case est_but is
			when none => 
				if( button1 = '1' or button2 = '1' or button3 = '1' or button4 = '1') then
					est_but_next <= sendTick;
				end if;
			when sendTick =>
				if( button1 = '1' ) then
					est_but_next <= sBut0;
				elsif ( button2 = '1' ) then
					est_but_next <= sBut1;
				elsif ( button3 = '1' ) then
					est_but_next <= sBut2;
				elsif ( button4 = '1' ) then
					est_but_next <= sBut3;
				end if;
			when sBut0 =>
				if(lcd_tick = '1') then
					est_but_next <= none;
				end if;
			when sBut1 =>
				if(lcd_tick = '1') then
					est_but_next <= none;
				end if;
			when sBut2 =>
				if(lcd_tick = '1') then
					est_but_next <= none;
				end if;
			when sBut3 =>
				if(lcd_tick = '1') then
					est_but_next <= none;
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
	butt1 : entity work.debounce
		port map(
			clk => clk,
			button => btn1,
			result => button1
		);
	butt2 : entity work.debounce
		port map(
			clk => clk,
			button => btn2,
			result => button2
		);
	butt3 : entity work.debounce
		port map(
			clk => clk,
			button => btn3,
			result => button3
		);
	butt4 : entity work.debounce
		port map(
			clk => clk,
			button => btn4,
			result => button4
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
	txt_unit : entity	work.rom
		port map(
			addr => romAddr,
			dato => ascii
		);
		lcd_data_in <= "00101000" when( est_reg = lcd_set ) else
							"00000110" when( est_reg = lcd_entry ) else
							"00001100" when( est_reg = lcd_on ) else
							"00000001" when( est_reg = lcd_clear ) else
							ascii when ( est_reg = sendText ) else
							(others => '0');
		lcd_rs <= '0' when(est_reg=lcd_set or est_reg = lcd_entry or est_reg = lcd_on or est_reg = lcd_clear) else '1';
		wait_time <= std_logic_vector( to_unsigned( 82000, 20 ) ) when ( est_reg=wait_clear ) else
						(others => '0');
		romAddr <=  "00" when (est_but = sBut0) else
						"01" when (est_but = sBut1) else
						"10" when (est_but = sBut2) else
						"11" when (est_but = sBut3);
		dataUp <= '1' when (est_but = sendTick) else '0';
	end Behavioral;

