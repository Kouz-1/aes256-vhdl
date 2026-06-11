----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 26.02.2026 17:15:40
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: Round1 - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Generic intermediate round stage for the fully-pipelined core.  Applies
-- MainSteps, expands the key with KeyExpansion, and adds the round key.
-- SEL selects which 128-bit half of KEY feeds AddRoundKey.
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

entity Round1 is
    Generic (N : integer := 256);
    Port ( PLAIN_TEXT : in STD_LOGIC_VECTOR (127 downto 0);
           KEY : in STD_LOGIC_VECTOR (N-1 downto 0);
           RST : in STD_LOGIC;
           SEL : in STD_LOGIC;
           RCON : in STD_LOGIC_VECTOR(7 downto 0);
           FINAL_ROUND : in STD_LOGIC;
           CIPHER : out STD_LOGIC_VECTOR (127 downto 0);
           SUBKEY : out STD_LOGIC_VECTOR (N-1 downto 0));
end Round1;

architecture Behavioral of Round1 is
Signal To_AddRoundKey, KEY_MSB_LSB, PLAIN_TEXT_RST : STD_LOGIC_VECTOR(127 downto 0);
begin

KEY_MSB_LSB <= KEY(N-1 downto 128) WHEN SEL ='0' ELSE KEY(127 downto 0);
PLAIN_TEXT_RST <= (OTHERS => '0') WHEN RST ='0' ELSE PLAIN_TEXT;

Inst_MainSteps : entity work.MainSteps
    Port map (
        DATA_IN => PLAIN_TEXT_RST,
        FINAL_ROUND => '0',
        DATA_OUT => To_AddRoundKey
        );

Inst_AddRoundKey1 : entity work.AddRoundKey
    Port map (
        DATA_IN1 => To_AddRoundKey,
        DATA_IN2 => KEY_MSB_LSB,
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
