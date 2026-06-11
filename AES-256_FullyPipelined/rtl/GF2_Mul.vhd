----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 14.02.2026 09:12:05
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: GF2_Mul - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Combinational multiplier over GF(2^8) using the AES irreducible polynomial
-- (x^8+x^4+x^3+x+1).  Computes the product of two bytes used by MixColumns.
-- 
-- Dependencies: --
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

entity GF2_Mul is
    Port ( 
           DATA_IN : in STD_LOGIC_VECTOR (7 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (7 downto 0));
end GF2_Mul;

architecture Behavioral of GF2_Mul is
Signal IN_SHIFTED, XOR_MSB : STD_LOGIC_VECTOR( 7 downto 0);
begin

     IN_SHIFTED <= DATA_IN(6 downto 0) & '0';
     XOR_MSB <= "000" & DATA_IN(7) & DATA_IN(7) & '0' & DATA_IN(7) & DATA_IN(7);
     DATA_OUT <= IN_SHIFTED XOR XOR_MSB;

end Behavioral;
