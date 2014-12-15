----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:21:00 11/22/2014 
-- Design Name: 
-- Module Name:    timer - Behavioral 
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
entity timer is
	port(
		clr : in			std_logic;
		clk : in			std_logic;
		sclr : in		std_logic;
		timeout : in	std_logic_vector(19 downto 0);
		tick : out 		std_logic
	);
end entity timer;

architecture data_flow of timer is
	signal cont_reg, cont_next : unsigned(19 downto 0);
	signal timeout_u : unsigned(19 downto 0);
begin
	process( clr, clk )
	begin
		if( clr = '1' ) then
			cont_reg <= ( others => '0' );
		elsif( clk'event and clk = '1' ) then
			cont_reg <= cont_next;
		end if;
	end process;
	
	cont_next <= ( others => '0' ) when ( sclr = '1' )  else
					 cont_reg + 1 when ( cont_reg < timeout_u ) else
					 ( others => '0' );
					 
	tick <= '1' when ( cont_reg = timeout_u ) else
			  '0';
			  
	timeout_u <= unsigned(timeout);
end architecture data_flow;