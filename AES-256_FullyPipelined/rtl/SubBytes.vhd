----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 13.02.2026 17:25:44
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: SubBytes - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Applies the AES SubBytes transformation to all 16 bytes of the 128-bit state
-- by instantiating 16 S_BOX units operating in parallel.
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

entity SubBytes is
    Port ( 
           DATA_IN : in STD_LOGIC_VECTOR (127 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (127 downto 0));
end SubBytes;

architecture Behavioral of SubBytes is

begin
boucle : for i in 0 to 15 generate
    instance_S_BOX : entity work.S_BOX
        port map (
            State => DATA_IN(7+(8*i) downto 8*i),
            S_Box_State => DATA_OUT(7+(8*i) downto 8*i)
            );
            
end generate boucle;

end Behavioral;
