----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 26.02.2026 13:48:17
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: MUXK - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: 2-to-1 multiplexer for the N-bit key feedback path of the iterative core.
-- Selects the original key (cycle 0) or the previously expanded round key.
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

entity MUXK is
    Generic ( TAILLE : integer := 128);
    Port ( DATA_IN1 : in STD_LOGIC_VECTOR (TAILLE - 1 downto 0);
           DATA_IN2 : in STD_LOGIC_VECTOR (TAILLE - 1 downto 0);
           COUNTER : in STD_LOGIC_VECTOR (3 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (TAILLE - 1 downto 0));
end MUXK;

architecture Behavioral of MUXK is

begin
DATA_OUT <= DATA_IN1 when (COUNTER = "0001" OR COUNTER ="0010") else DATA_IN2;
end Behavioral;
