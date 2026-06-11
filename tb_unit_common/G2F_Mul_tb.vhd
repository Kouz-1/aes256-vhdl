----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2026 10:44:54
-- Design Name: 
-- Module Name: G2F_Mul_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity G2F_Mul_tb is
--  Port ( );
end G2F_Mul_tb;

architecture Behavioral of G2F_Mul_tb is

Signal CLK_TB, RST_TB : STD_LOGIC;
Signal DATA_IN_TB, DATA_OUT_TB :STD_LOGIC_VECTOR(7 downto 0);
Constant CLK_PERIOD : time := 10 ns;

begin

U: entity work.GF2_Mul
    port map (
        DATA_IN => DATA_IN_TB,
        DATA_OUT => DATA_OUT_TB
        );

CLK_PERIODD : process
begin
CLK_TB <= '0';
wait for CLK_PERIOD/2;
CLK_TB <= '1';
wait for CLK_PERIOD/2;
end process CLK_PERIODD;

stimulus : process
begin
RST_TB <= '0';
DATA_IN_TB <= x"b0";
wait;
end process stimulus;
end Behavioral;
