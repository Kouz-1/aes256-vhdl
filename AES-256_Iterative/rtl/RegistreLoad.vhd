----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 26.02.2026 13:17:48
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: RegistreLoad - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Synchronous register with a LOAD enable signal.  Captures DATA_IN on the
-- rising edge only when LOAD='1'; otherwise holds the current value.
-- Used in the iterative core to latch the expanded round key.
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

entity RegistreLoad is
    Port ( CLK      : in  STD_LOGIC;
        DATA_IN  : in  STD_LOGIC_VECTOR(255 downto 0);
        DATA_OUT : out STD_LOGIC_VECTOR(255 downto 0);
        LOAD     : out STD_LOGIC);
end  RegistreLoad;

architecture Behavioral of RegistreLoad is

signal LOAD_int : STD_LOGIC := '1';
begin

    process(CLK)
    begin
        if rising_edge(CLK) then
                if LOAD_int = '1' then
                    DATA_OUT <= DATA_IN;
                end if;
                LOAD_int <= NOT LOAD_int;
            end if;
    end process;

    LOAD <= LOAD_int;


end Behavioral;

