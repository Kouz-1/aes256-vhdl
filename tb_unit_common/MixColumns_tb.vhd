----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.02.2026 13:35:43
-- Design Name: 
-- Module Name: MixColumns_tb - Behavioral
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

entity MixColumns_tb is
--  Port ( );
end MixColumns_tb;

architecture Behavioral of MixColumns_tb is

Signal DATA_IN_tb , DATA_OUT_tb : STD_LOGIC_VECTOR ( 127 downto 0 );
begin

instance : entity work.MixColumns
    port map (
        DATA_IN => DATA_IN_tb,
        DATA_OUT => DATA_OUT_tb
        );

Stimulus : process
begin
DATA_IN_tb <= x"000102030405060708090a0b0c0d0e0f";
wait;
end process Stimulus;

end Behavioral;
