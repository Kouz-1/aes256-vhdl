----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 22.02.2026 14:41:28
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: MainSteps - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Combines SubBytes, ShiftRows, and MixColumns into a single pipeline stage.
-- MixColumns is bypassed (FINAL_ROUND='1') during the last AES round.
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

entity MainSteps is
    Port ( CLK : in STD_LOGIC;
           DATA_IN : in STD_LOGIC_VECTOR (127 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (127 downto 0);
           FINAL_ROUND : in STD_LOGIC);
end MainSteps;

architecture Behavioral of MainSteps is
Signal REG_IN, REG_OUT, AFTER_MixColumns, AFTER_SubBytes : STD_LOGIC_VECTOR(127 downto 0);
begin

Inst_SubBytes : entity work.SubBytes
    Port map (
        DATA_IN => DATA_IN,
        DATA_OUT => AFTER_SubBytes
        );
        
Inst_ShiftRows : entity work.ShiftRows
    Port map (
        DATA_IN => AFTER_SubBytes,
        DATA_OUT => REG_IN
        );
        
Inst_Registre : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REG_IN,
        DATA_OUT => REG_OUT,
        CLK => CLK
        );
        
Inst_MixColumns : entity work.MixColumns
    Port map (
        DATA_IN => REG_OUT,
        DATA_OUT => AFTER_MixColumns
        );   
           
DATA_OUT <= AFTER_MixColumns WHEN FINAL_ROUND='0' ELSE REG_OUT;
         
end Behavioral;
