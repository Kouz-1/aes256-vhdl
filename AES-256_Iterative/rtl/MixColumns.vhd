----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 14.02.2026 12:20:37
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: MixColumns - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Applies the MixColumns linear transformation to all four columns of the
-- 128-bit AES state by instantiating four Columns_Mul units in parallel.
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

entity MixColumns is
    Port ( 
           DATA_IN : in STD_LOGIC_VECTOR (127 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (127 downto 0));
end MixColumns;

architecture Behavioral of MixColumns is

begin
U0 : entity work.Columns_Mul
    port map (
        DATA_IN => DATA_IN(127 downto 96),
        DATA_OUT => DATA_OUT(127 downto 96)
        );

U1 : entity work.Columns_Mul
    port map (
        DATA_IN => DATA_IN(95 downto 64),
        DATA_OUT => DATA_OUT(95 downto 64)
        );
        
 U2 : entity work.Columns_Mul
    port map (
        DATA_IN => DATA_IN(63 downto 32),
        DATA_OUT => DATA_OUT(63 downto 32)
        );
        
U3 : entity work.Columns_Mul
    port map (
        DATA_IN => DATA_IN(31 downto 0),
        DATA_OUT => DATA_OUT(31 downto 0)
        );        

end Behavioral;
