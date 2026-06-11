----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 14.02.2026 16:19:08
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: AddRoundKey - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: XORs the 128-bit AES state with the current 128-bit round key.
-- Used at the start of encryption and at the end of every round.
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

entity AddRoundKey is
    Port ( DATA_IN1 : in STD_LOGIC_VECTOR (127 downto 0);
           DATA_IN2 : in STD_LOGIC_VECTOR (127 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (127 downto 0));
end AddRoundKey;

architecture Behavioral of AddRoundKey is

begin

DATA_OUT <= DATA_IN1 XOR DATA_IN2;

end Behavioral;
