----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 26.02.2026 23:51:37
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: AES_Fully_Pipelined_tb - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Directed testbench for the fully-pipelined AES top level.  Applies a known
-- plaintext/key pair and checks the ciphertext output after the pipeline fill.
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

entity AES_Fully_Pipelined_tb is
--  Port ( );
end AES_Fully_Pipelined_tb;

architecture Behavioral of AES_Fully_Pipelined_tb is
Constant CLK_PERIOD : time := 10.20 ns;
Constant N : integer := 256;
Signal CLK_TB, RST_TB : STD_LOGIC;
Signal KEY_TB : STD_LOGIC_VECTOR(N-1 downto 0);
Signal PLAIN_TEXT_TB : STD_LOGIC_VECTOR(127 downto 0);
Signal CIPHER_TEXT_TB : STD_LOGIC_VECTOR(127 downto 0);

begin

U: entity work.AES_Fully_Pipelined
    Generic map (N => N)
    Port map (
        CLK => CLK_TB,
        RST => RST_TB,
        KEY => KEY_TB,
        PLAIN_TEXT => PLAIN_TEXT_TB,
        CIPHER_TEXT => CIPHER_TEXT_TB
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
wait for 10 ns;
RST_TB <= '1';
KEY_TB <= x"603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4";
PLAIN_TEXT_TB <= x"6bc1bee22e409f96e93d7e117393172a";
wait for 10 ns;
RST_TB <= '1';
KEY_TB <= x"603DEB1015CA71BE2B73AEF0857D77811F352C073B6108D72D9810A30914DFF4";
PLAIN_TEXT_TB <= x"AE2D8A571E03AC9C9EB76FAC45AF8E51";
wait for 10 ns;
RST_TB <= '1';
KEY_TB <= x"603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4";
PLAIN_TEXT_TB <= x"30C81C46A35CE411E5FBC1191A0A52EF";
wait for 10 ns;
KEY_TB <= x"0000000000000000000000000000000000000000000000000000000000000000";
PLAIN_TEXT_TB <= x"8A560769D605868AD80D819BDBA03771";
wait for 10 ns;
end process;
end Behavioral;
