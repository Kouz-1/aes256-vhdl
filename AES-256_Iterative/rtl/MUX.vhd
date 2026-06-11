----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 22.02.2026 16:23:17
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: MUX - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-to-1 multiplexer for the 128-bit state feedback path of the iterative core.
-- Selects the initial plaintext (cycle 0) or the fed-back ciphertext state.
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

entity MUX is
    Generic ( TAILLE : integer := 128);
    Port ( DATA_IN1 : in STD_LOGIC_VECTOR (TAILLE - 1 downto 0);
           DATA_IN2 : in STD_LOGIC_VECTOR (TAILLE - 1 downto 0);
           COUNTER : in STD_LOGIC_VECTOR (3 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (TAILLE - 1 downto 0));
end MUX;

architecture Behavioral of MUX is

begin
DATA_OUT <= DATA_IN1 when (COUNTER = "0001") else DATA_IN2;
end Behavioral;
