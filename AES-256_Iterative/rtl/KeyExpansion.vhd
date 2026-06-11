----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 14.02.2026 14:27:11
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: KeyExpansion - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Wrapper around KeyExpansionCore.  Accepts the current N-bit key and RCON,
-- and outputs the next round key.  Used by InitialRound, Round1, and FinalRound.
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

entity KeyExpansion is
    Generic (N : positive := 256);
    Port ( KEY : in STD_LOGIC_VECTOR (N-1 downto 0);
           NEXT_KEY : out STD_LOGIC_VECTOR (N-1 downto 0);
           RCON : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC
           );
end KeyExpansion;

architecture Behavioral of KeyExpansion is

Signal KEY_RST : STD_LOGIC_VECTOR(N-1 downto 0);

begin

KEY_RST <= (OTHERS => '0') WHEN RST = '0' ELSE KEY;

V: entity work. KeyExpansionCore
    generic map ( N => N)
    port map (
        KEY => KEY,
        RCON => RCON,
        NEXT_KEY => NEXT_KEY
        );
                
end Behavioral;
