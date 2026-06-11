----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 13.02.2026 11:29:42
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: Registre - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Generic synchronous D-type register with configurable data width (SIZE).
-- Captures DATA_IN on the rising clock edge and drives DATA_OUT.
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

entity Registre is
    Generic (SIZE : integer := 256);
    Port ( CLK : in STD_LOGIC;
           DATA_IN : in STD_LOGIC_VECTOR (SIZE - 1 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (SIZE - 1 downto 0));
end Registre;

architecture Behavioral of Registre is

Signal CURRENTS : STD_LOGIC_VECTOR( SIZE - 1 downto 0);

begin
CURRENTS <= DATA_IN;
    process(CLK)
        begin
            if(rising_edge(CLK)) then
                DATA_OUT <= CURRENTS;
            end if;
    end process;
     
end Behavioral;
