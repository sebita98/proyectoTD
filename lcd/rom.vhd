----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:08:49 11/22/2014 
-- Design Name: 
-- Module Name:    rom - Behavioral 
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

entity	rom is
	port(
		addr : in	std_logic_vector(1 downto 0);
		dato : out	std_logic_vector(3 downto 0)
		);
end entity rom;

architecture rom_imp of rom is
	constant ADDR_WIDTH : integer := 2;
	constant DATA_WIDTH : integer := 4;
	
	type mem_2d_type is array (0 to 3)
		of std_logic_vector(DATA_WIDTH-1 downto 0);	
		
	constant	ROM_PROG : mem_2d_type :=(
		"0100",	-- 0, H
		"0110", -- 1, o
		"0110", -- 2, l
		"0110" -- 3, a
		);		
begin
	dato <= ROM_PROG(to_integer(unsigned(addr)));
end architecture rom_imp;