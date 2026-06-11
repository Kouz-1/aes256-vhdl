----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.02.2026 18:03:31
-- Design Name: 
-- Module Name: SubBytes_tb - Behavioral
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

entity SubBytes_tb is
--  Port ( );
end SubBytes_tb;

architecture Behavioral of SubBytes_tb is

Signal DATA_IN_tb , DATA_OUT_tb : STD_LOGIC_VECTOR ( 127 downto 0 );
begin
instance : entity work.SubBytes
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
