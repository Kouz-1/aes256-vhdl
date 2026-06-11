----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 27.02.2026 13:32:51
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: FinalRound - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Last round stage of the fully-pipelined core.  Applies SubBytes, ShiftRows,
-- and AddRoundKey (MixColumns omitted), completing the AES encryption.
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

entity FinalRound is
    Generic ( N : integer := 256);
    Port ( PLAIN_TEXT : in STD_LOGIC_VECTOR (127 downto 0);
           KEY : in STD_LOGIC_VECTOR (N-1 downto 0);
           RST : in STD_LOGIC;
           CIPHER : out STD_LOGIC_VECTOR (127 downto 0));
end FinalRound;

architecture Behavioral of FinalRound is

Signal AFTER_ShiftRows, AFTER_SubBytes : STD_LOGIC_VECTOR(127 downto 0);
begin

Inst_SubBytes : entity work.SubBytes
    Port map (
        DATA_IN => PLAIN_TEXT,
        DATA_OUT => AFTER_SubBytes
        );
        
Inst_ShiftRows : entity work.ShiftRows
    Port map (
        DATA_IN => AFTER_SubBytes,
        DATA_OUT => AFTER_ShiftRows
        );  
Inst_AddRoundKey : entity work.AddRoundKey
    Port map (
        DATA_IN1 => AFTER_ShiftRows,
        DATA_IN2 => KEY(255 downto 128),
        DATA_OUT => CIPHER
        );          

end Behavioral;
