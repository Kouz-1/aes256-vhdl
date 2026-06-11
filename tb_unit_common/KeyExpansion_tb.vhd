----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.02.2026 17:21:27
-- Design Name: 
-- Module Name: KeyExpansion_tb - Behavioral
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

entity KeyExpansion_tb is
--  Port ( );
end KeyExpansion_tb;

architecture Behavioral of KeyExpansion_tb is
Constant CLK_PERIOD : time := 100ns;
Constant N : integer := 256;
Signal CLK, RST : STD_LOGIC;
Signal KEY, NEXT_KEY : STD_LOGIC_VECTOR(N-1 downto 0);
Signal RCON : STD_LOGIC_VECTOR(7 downto 0);

begin

U: entity work.KeyExpansion
    Generic map ( N => 256)
    Port map (
        KEY => KEY,
        NEXT_KEY => NEXT_KEY,
        RCON => RCON,
        CLK => CLK,
        RST => RST
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
KEY <= x"603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4";
RCON <= x"01";
wait for 20000 ns;
end process;

end Behavioral;
