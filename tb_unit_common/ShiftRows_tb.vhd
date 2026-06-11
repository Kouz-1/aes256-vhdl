----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.02.2026 11:04:47
-- Design Name: 
-- Module Name: ShiftRows_tb - Behavioral
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

entity ShiftRows_tb is
--  Port ( );
end ShiftRows_tb;

architecture Behavioral of ShiftRows_tb is

Signal CLK_TB, RST_TB : STD_LOGIC;
Signal DATA_IN_TB, DATA_OUT_TB : STD_LOGIC_VECTOR (127 downto 0);
Constant CLK_PERIOD : time := 10 ns;

begin

U: entity work.ShiftRows
    port map (
        CLK => CLK_TB,
        RST => RST_TB,
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
RST_TB <='0';
DATA_IN_TB <= x"b0b1b2b3b4b5b6b7b8b9babbbcbdbebf";
wait;
end process stimulus;

end Behavioral;
