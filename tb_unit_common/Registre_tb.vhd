----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2026 11:43:50
-- Design Name: 
-- Module Name: Registre_tb - Behavioral
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

entity Registre_tb is
end Registre_tb;

architecture Behavioral of Registre_tb is

Constant SIZE_TB : integer := 12;
Constant CLK_PERIOD : time := 10 ns;

SIGNAL CLK_TB, RST_TB : STD_LOGIC;
Signal DATA_IN_TB : STD_LOGIC_VECTOR (SIZE_TB - 1 downto 0);
Signal DATA_OUT_TB : STD_LOGIC_VECTOR (SIZE_TB - 1 downto 0);

begin
UUT: entity work.Registre
    generic map ( SIZE => SIZE_TB )
    port map (
        RST => RST_TB,
        CLK => CLK_TB,
        DATA_IN => DATA_IN_TB,
        DATA_OUT => DATA_OUT_TB
        );

CLK_PROCESS : Process
begin
    CLK_TB <= '0';
    wait for CLK_PERIOD / 2;
    CLK_TB <= '1';
    wait for CLK_PERIOD / 2;
end process;

Stimulus : Process
begin
    DATA_IN_TB <= "110110101111";
    RST_TB <= '0';
    wait for 2 ns;
    
    DATA_IN_TB <= "000000001111";
    RST_TB <= '0';
    wait for 8 ns;
    
    DATA_IN_TB <= "000000000000";
    RST_TB <= '0';
    wait for 12 ns;
    
    DATA_IN_TB <= "111111111111";
    RST_TB <= '0';
    wait for 10 ns;
   
end process;

end Behavioral;
