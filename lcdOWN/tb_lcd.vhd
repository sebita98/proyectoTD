--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   14:19:18 12/14/2014
-- Design Name:   
-- Module Name:   C:/proyectoTD/lcdOWN/tb_lcd.vhd
-- Project Name:  lcdOWN
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lcd
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_lcd IS
END tb_lcd;
 
ARCHITECTURE behavior OF tb_lcd IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT lcd
    PORT(
         clr : IN  std_logic;
         clk : IN  std_logic;
         start : IN  std_logic;
         lcd_data : OUT  std_logic_vector(3 downto 0);
         lcd_rs : OUT  std_logic;
         lcd_rw : OUT  std_logic;
         lcd_e : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clk : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal lcd_data : std_logic_vector(3 downto 0);
   signal lcd_rs : std_logic;
   signal lcd_rw : std_logic;
   signal lcd_e : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lcd PORT MAP (
          clr => clr,
          clk => clk,
          start => start,
          lcd_data => lcd_data,
          lcd_rs => lcd_rs,
          lcd_rw => lcd_rw,
          lcd_e => lcd_e
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		start <= '1';
      -- insert stimulus here 
      wait for 25 ms;
   end process;

END;
