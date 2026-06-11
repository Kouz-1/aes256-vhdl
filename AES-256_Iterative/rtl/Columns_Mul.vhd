----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 14.02.2026 09:36:41
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: Columns_Mul - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Computes the MixColumns matrix product for one 32-bit column of the AES state.
-- Instantiates four GF2_Mul units and XORs results per the AES specification.
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

entity Columns_Mul is
    Port ( 
           DATA_IN : in STD_LOGIC_VECTOR (31 downto 0);
           DATA_OUT : out STD_LOGIC_VECTOR (31 downto 0));
end Columns_Mul;

architecture Behavioral of Columns_Mul is
  signal xtime_b0, xtime_b1, xtime_b2, xtime_b3 : STD_LOGIC_VECTOR(7 downto 0);
begin
  GF_b0: entity work.GF2_Mul port map(DATA_IN => DATA_IN(31 downto 24), DATA_OUT => xtime_b0);
  GF_b1: entity work.GF2_Mul port map(DATA_IN => DATA_IN(23 downto 16), DATA_OUT => xtime_b1);
  GF_b2: entity work.GF2_Mul port map(DATA_IN => DATA_IN(15 downto 8),  DATA_OUT => xtime_b2);
  GF_b3: entity work.GF2_Mul port map(DATA_IN => DATA_IN(7 downto 0),   DATA_OUT => xtime_b3);

  -- 2*b = xtime(b),  3*b = xtime(b) XOR b
  DATA_OUT(31 downto 24) <= xtime_b0 
                            XOR (xtime_b1 XOR DATA_IN(23 downto 16))
                            XOR DATA_IN(15 downto 8) 
                            XOR DATA_IN(7 downto 0);

  DATA_OUT(23 downto 16) <= DATA_IN(31 downto 24) 
                            XOR xtime_b1 
                            XOR (xtime_b2 XOR DATA_IN(15 downto 8))
                            XOR DATA_IN(7 downto 0);

  DATA_OUT(15 downto 8)  <= DATA_IN(31 downto 24) 
                            XOR DATA_IN(23 downto 16) 
                            XOR xtime_b2 
                            XOR (xtime_b3 XOR DATA_IN(7 downto 0));

  DATA_OUT(7 downto 0)   <= (xtime_b0 XOR DATA_IN(31 downto 24)) 
                            XOR DATA_IN(23 downto 16) 
                            XOR DATA_IN(15 downto 8) 
                            XOR xtime_b3;
end Behavioral;
