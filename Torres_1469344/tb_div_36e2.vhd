--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:11:56 12/15/2014
-- Design Name:   
-- Module Name:   /home/seba/Documents/proyectoTD/proyectoTD/Torres_1469344/tb_div_36e2.vhd
-- Project Name:  Torres_1469344
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: div_36e2
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
 
ENTITY tb_div_36e2 IS
END tb_div_36e2;
 
ARCHITECTURE behavior OF tb_div_36e2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT div_36e2
    PORT(
         clk_en : IN  std_logic;
         syn_clr : IN  std_logic;
         clk : IN  std_logic;
         tick_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk_en : std_logic := '0';
   signal syn_clr : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal tick_out : std_logic;

   -- Clock period definitions
   constant clk_en_period : time := 10 ns;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: div_36e2 PORT MAP (
          clk_en => clk_en,
          syn_clr => syn_clr,
          clk => clk,
          tick_out => tick_out
        );
 
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
		clk_en <= '1';
		wait for clk_period*3700;
		syn_clr <= '1';
		wait for clk_period;
		syn_clr <= '0';
		wait for clk_period*3700;
		assert false report "Simulation Completed" severity failure;
      -- insert stimulus here 

      wait;
   end process;

END;
