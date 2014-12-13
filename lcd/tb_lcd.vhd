--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:20:49 12/13/2014
-- Design Name:   
-- Module Name:   /home/seba/Documents/shared/lcd/tb_lcd.vhd
-- Project Name:  lcd
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: lcd_top
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
 
    COMPONENT lcd_top
    PORT(
         clr : IN  std_logic;
         clk : IN  std_logic;
         lcd_rs : OUT  std_logic;
         lcd_e : OUT  std_logic;
         lcd_data : OUT  std_logic_vector(3 downto 0)
--         but1 : IN  std_logic;
--         but2 : IN  std_logic;
--         but3 : IN  std_logic;
--         but4 : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal lcd_rs : std_logic;
   signal lcd_e : std_logic;
   signal lcd_data : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: lcd_top PORT MAP (
          clr => clr,
          clk => clk,
          lcd_rs => lcd_rs,
          lcd_e => lcd_e,
          lcd_data => lcd_data
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

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
