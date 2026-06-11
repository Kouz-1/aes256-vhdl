----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 26.02.2026 01:56:51
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: MUXSpecial - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Special-purpose multiplexer that selects between the registered NEXT_KEY and
-- the direct MUXKIN value based on the LOAD signal, used to initialise the
-- key expansion pipeline in the iterative core.
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

entity MUXSpecial is
    Port ( SEL     : in  STD_LOGIC;
        DATA_IN : in  STD_LOGIC_VECTOR(255 downto 0);
        DATA_OUT: out STD_LOGIC_VECTOR(127 downto 0));
end MUXSpecial;

architecture Behavioral of MUXSpecial is
begin
process(SEL, DATA_IN)
    begin
        if SEL = '0' then
            DATA_OUT <= DATA_IN(255 downto 128); -- MSB
        else
            DATA_OUT <= DATA_IN(127 downto 0);   -- LSB
        end if;
    end process;

end Behavioral;
