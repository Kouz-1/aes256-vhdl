----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 13.02.2026 19:14:15
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: ShiftRows - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Implements the AES ShiftRows step: byte-level cyclic left-shift of each row
-- of the 4x4 state matrix (rows 0-3 shifted by 0-3 positions respectively).
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

entity ShiftRows is
    Port ( 
           DATA_IN : in STD_LOGIC_VECTOR (127 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (127 downto 0));
end ShiftRows;

architecture Behavioral of ShiftRows is

Type byte_array is array (0 to 15) of STD_LOGIC_VECTOR(7 downto 0);
Signal IN_TEMP  : byte_array;
Signal OUT_TEMP : byte_array;

begin

        IN_TEMP(0)  <= DATA_IN(127 downto 120);
        IN_TEMP(1)  <= DATA_IN(119 downto 112);
        IN_TEMP(2)  <= DATA_IN(111 downto 104);
        IN_TEMP(3)  <= DATA_IN(103 downto 96);
        IN_TEMP(4)  <= DATA_IN(95 downto 88);
        IN_TEMP(5)  <= DATA_IN(87 downto 80);
        IN_TEMP(6)  <= DATA_IN(79 downto 72);
        IN_TEMP(7)  <= DATA_IN(71 downto 64);
        IN_TEMP(8)  <= DATA_IN(63 downto 56);
        IN_TEMP(9)  <= DATA_IN(55 downto 48);
        IN_TEMP(10) <= DATA_IN(47 downto 40);
        IN_TEMP(11) <= DATA_IN(39 downto 32);
        IN_TEMP(12) <= DATA_IN(31 downto 24);
        IN_TEMP(13) <= DATA_IN(23 downto 16);
        IN_TEMP(14) <= DATA_IN(15 downto 8);
        IN_TEMP(15) <= DATA_IN(7 downto 0);

        -- Row 0 (no shift)
        OUT_TEMP(0)  <= IN_TEMP(0);
        OUT_TEMP(4)  <= IN_TEMP(4);
        OUT_TEMP(8)  <= IN_TEMP(8);
        OUT_TEMP(12) <= IN_TEMP(12);
    
        -- Row 1 (shift left by 1)
        OUT_TEMP(1)  <= IN_TEMP(5);
        OUT_TEMP(5)  <= IN_TEMP(9);
        OUT_TEMP(9)  <= IN_TEMP(13);
        OUT_TEMP(13) <= IN_TEMP(1);
    
        -- Row 2 (shift left by 2)
        OUT_TEMP(2)  <= IN_TEMP(10);
        OUT_TEMP(6)  <= IN_TEMP(14);
        OUT_TEMP(10) <= IN_TEMP(2);
        OUT_TEMP(14) <= IN_TEMP(6);
    
        -- Row 3 (shift left by 3)
        OUT_TEMP(3)  <= IN_TEMP(15);
        OUT_TEMP(7)  <= IN_TEMP(3);
        OUT_TEMP(11) <= IN_TEMP(7);
        OUT_TEMP(15) <= IN_TEMP(11);

    DATA_OUT <=
        OUT_TEMP(0)  & OUT_TEMP(1)  & OUT_TEMP(2)  & OUT_TEMP(3)  &
        OUT_TEMP(4)  & OUT_TEMP(5)  & OUT_TEMP(6)  & OUT_TEMP(7)  &
        OUT_TEMP(8)  & OUT_TEMP(9)  & OUT_TEMP(10) & OUT_TEMP(11) &
        OUT_TEMP(12) & OUT_TEMP(13) & OUT_TEMP(14) & OUT_TEMP(15);
        

end Behavioral;
