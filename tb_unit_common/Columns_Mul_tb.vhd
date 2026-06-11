----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2026 10:44:54
-- Design Name: 
-- Module Name: Columns_Mul_tb - Behavioral
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

entity Columns_Mul_tb is
--  Port ( );
end Columns_Mul_tb;

architecture Behavioral of Columns_Mul_tb is

Signal DATA_IN_TB, DATA_OUT_TB :STD_LOGIC_VECTOR(31 downto 0);
Constant CLK_PERIOD : time := 10 ns;

begin

U: entity work.Columns_Mul
    port map (
        DATA_IN => DATA_IN_TB,
        DATA_OUT => DATA_OUT_TB
        );
        

stimulus : process
begin
DATA_IN_TB <= x"6347a2f0";
wait;
end process stimulus;

end Behavioral;
