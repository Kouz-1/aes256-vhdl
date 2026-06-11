----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2026 17:25:07
-- Design Name: 
-- Module Name: Controller_tb - Behavioral
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

entity Controller_tb is
--  Port ( );
end Controller_tb;

architecture Behavioral of Controller_tb is
Constant CLK_PERIOD : time := 10ns;
Constant N : integer := 256;
Signal CLK, RST, FINAL_ROUND : STD_LOGIC;
Signal RCON : STD_LOGIC_VECTOR(7 downto 0);
Signal COUNTER : STD_LOGIC_VECTOR(3 downto 0);
begin

U: entity work.Controller
    Generic map ( N => N)
    Port map (
        FINAL_ROUND => FINAL_ROUND,
        RCON => RCON,
        CLK => CLK,
        RST => RST,
        COUNTERR => COUNTER
        );
        
Process
begin
CLK <= '0';
wait for CLK_PERIOD/2;
CLK <= '1';
wait for CLK_PERIOD/2;
end process;

process
begin
RST <= '0';
wait for 20 ns;
RST <= '1';
wait for 200 ns;
RST <= '0';
wait for 20 ns;
end process;

end Behavioral;
