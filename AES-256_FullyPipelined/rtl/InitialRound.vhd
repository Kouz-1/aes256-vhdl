----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 22.02.2026 14:26:20
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: InitialRound - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Executes round 0 of AES: applies MainSteps to the plaintext, derives
-- the first round subkey via KeyExpansion, and adds it with AddRoundKey.
-- RST='0' forces the output to zero.
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

entity InitialRound is
    Generic ( N : integer := 256);
    Port ( PLAIN_TEXT : in STD_LOGIC_VECTOR (127 downto 0);
           KEY : in STD_LOGIC_VECTOR (N-1 downto 0);
           RST : in STD_LOGIC;
           RCON : in STD_LOGIC_VECTOR(7 downto 0);
           FINAL_ROUND : in STD_LOGIC;
           CIPHER : out STD_LOGIC_VECTOR (127 downto 0);
           SUBKEY : out STD_LOGIC_VECTOR (N-1 downto 0));
end InitialRound;

architecture Behavioral of InitialRound is
Signal To_AddRoundKey, PLAIN_TEXT_RST : STD_LOGIC_VECTOR(127 downto 0);
begin

PLAIN_TEXT_RST <= (OTHERS => '0') WHEN RST ='0' ELSE PLAIN_TEXT;

Inst_MainSteps : entity work.MainSteps
    Port map (
        DATA_IN => PLAIN_TEXT_RST,
        FINAL_ROUND => FINAL_ROUND,
        DATA_OUT => To_AddRoundKey
        );

Inst_AddRoundKey1 : entity work.AddRoundKey
    Port map (
        DATA_IN1 => To_AddRoundKey,
        DATA_IN2 => KEY(127 downto 0),
        DATA_OUT => CIPHER
        );
        
Inst_KeyExpansion : entity work.KeyExpansion
    Generic map (N => N)
    Port map (
        KEY => KEY,
        NEXT_KEY => SUBKEY,
        RCON => RCON,
        RST => RST
        );
                
end Behavioral;
