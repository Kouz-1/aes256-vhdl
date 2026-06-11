----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 22.02.2026 16:29:44
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: AES_tb - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Directed testbench for the iterative AES top level.  Applies a fixed
-- plaintext/key stimulus and observes CIPHER_TEXT after 14 clock cycles.
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

entity AES_tb is
--  Port ( );
end AES_tb;

architecture Behavioral of AES_tb is
Constant CLK_PERIOD : time := 125 ns;
Constant N : integer := 256;
Signal CLK_TB, RST_TB, FINAL_ROUND : STD_LOGIC;
Signal KEY_TB : STD_LOGIC_VECTOR(N-1 downto 0);
Signal PLAIN_TEXT_TB : STD_LOGIC_VECTOR(127 downto 0);
Signal CIPHER_TEXT_TB, CIPHER_TEXT2_TB : STD_LOGIC_VECTOR(127 downto 0);

begin

U: entity work.AES
    Generic map (N => N)
    Port map (
        CLK => CLK_TB,
        RST => RST_TB,
        KEY => KEY_TB,
        PLAIN_TEXT => PLAIN_TEXT_TB,
        CIPHER_TEXT => CIPHER_TEXT_TB,
        CIPHER_TEXT2 => CIPHER_TEXT2_TB,
        FINAL_ROUNDD => FINAL_ROUND
        );

Process
begin
CLK_TB <= '0';
wait for CLK_PERIOD/2;
CLK_TB <= '1';
wait for CLK_PERIOD/2;
end process;

stimulus : process
begin
RST_TB <= '1';
KEY_TB <= x"000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f";
PLAIN_TEXT_TB <= x"00112233445566778899aabbccddeeff";
wait;
end process;
end Behavioral;
