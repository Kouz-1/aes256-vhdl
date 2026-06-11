----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 22.02.2026 14:53:53
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: MainRound - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Iterative main-round datapath.  Instantiates MainSteps and routes the result
-- back to the top-level feedback path for the next clock cycle.
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

entity MainRound is
    Generic ( N : integer := 256);
    Port ( 
           FINAL_ROUND : in STD_LOGIC;
           RST : in STD_LOGIC;
           PLAIN_TEXT : in STD_LOGIC_VECTOR (127 downto 0);
           CIPHER_TEXT : out STD_LOGIC_VECTOR (127 downto 0));
end MainRound;

architecture Behavioral of MainRound is

Signal PLAIN_TEXT_RST : STD_LOGIC_VECTOR(127 downto 0);

begin

PLAIN_TEXT_RST <= (OTHERS => '0') WHEN RST='0' ELSE PLAIN_TEXT;

Inst_MainSteps : entity work.MainSteps
    Port map (
        DATA_IN => PLAIN_TEXT,
        FINAL_ROUND => FINAL_ROUND,
        DATA_OUT => CIPHER_TEXT
        );
        
end Behavioral;
