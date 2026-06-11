----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 15.02.2026 23:55:13
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: Controller - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Round counter and RCON scheduler.  Generates the RCON byte and FINAL_ROUND
-- flag for each of the 14 AES-256 rounds (10 for AES-128, 12 for AES-192).
-- Parameterizable via generic N.
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller is
    Generic ( N : integer := 256);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           COUNTERR : out STD_LOGIC_VECTOR(3 downto 0);
           RCON : out STD_LOGIC_VECTOR (7 downto 0);
           FINAL_ROUND : out STD_LOGIC);
end Controller;

architecture Behavioral of Controller is

    -- ?? Internal signals ?????????????????????????????????????????????
    signal COUNTER      : integer range 0 to 15 := 15;
    signal MAX_ROUNDS   : integer range 0 to 15;
    signal FINAL_ROUND_INT : STD_LOGIC;
    
begin

    -- ?? Max Rounds decoder (combinational) ???????????????????????????
    -- Counter runs from 0 to MAX_ROUNDS-1, so:
    --   AES-128: 10 rounds ? counter 0..9  ? MAX = 9
    --   AES-192: 12 rounds ? counter 0..11 ? MAX = 11
    --   AES-256: 14 rounds ? counter 0..13 ? MAX = 13
    MAX_ROUNDS <= 10  when N = 128 else
                  12 when N = 192 else
                  14;  -- N = 256

    -- ?? Synchronous counter with active-low reset ????????????????????
    process(CLK, RST)
    begin
        if RST = '0' then
            COUNTER <= 0;
        elsif rising_edge(CLK) then
            if COUNTER < MAX_ROUNDS then
                COUNTER <= COUNTER + 1;
            else
                COUNTER <= 0;
            end if;
            -- Counter holds at MAX_ROUNDS when FINAL_ROUND reached
        end if;
    end process;

    -- ?? Comparator (combinational) ???????????????????????????????????
    FINAL_ROUND_INT <= '1' when COUNTER = MAX_ROUNDS  else '0';
    FINAL_ROUND     <= FINAL_ROUND_INT;

    -- ?? RCON ROM LUT (combinational, conditioned on N and COUNTER) ???
    process(COUNTER)
    begin
        if N = 128 then
            -- AES-128: 10 rounds, counter 0..9
            case COUNTER is
                when 0  => RCON <= x"01";
                when 1  => RCON <= x"02";
                when 2  => RCON <= x"04";
                when 3  => RCON <= x"08";
                when 4  => RCON <= x"10";
                when 5  => RCON <= x"20";
                when 6  => RCON <= x"40";
                when 7  => RCON <= x"80";
                when 8  => RCON <= x"1B";
                when 9  => RCON <= x"36";
                when others => RCON <= x"00";
            end case;

        elsif N = 192 then
            -- AES-192: 12 rounds, same RCON held for 2 consecutive rounds
            case COUNTER is
                when 0  => RCON <= x"01";
                when 1  => RCON <= x"01";
                when 2  => RCON <= x"02";
                when 3  => RCON <= x"04";
                when 4  => RCON <= x"04";
                when 5  => RCON <= x"08";
                when 6  => RCON <= x"10";
                when 7  => RCON <= x"10";
                when 8  => RCON <= x"20";
                when 9  => RCON <= x"40";
                when 10 => RCON <= x"40";
                when 11 => RCON <= x"80";
                when others => RCON <= x"00";
            end case;

        else
            -- AES-256: 14 rounds, same RCON held for 2 consecutive rounds
            case COUNTER is
                when 0  => RCON <= x"01";
                when 1  => RCON <= x"01";
                when 2  => RCON <= x"01"; --x"01"
                when 3  => RCON <= x"02"; --x"02"
                when 4  => RCON <= x"02"; --x"02"
                when 5  => RCON <= x"04"; --x"04"
                when 6  => RCON <= x"04"; --x"04"
                when 7  => RCON <= x"08";
                when 8  => RCON <= x"08";
                when 9  => RCON <= x"10";
                when 10  => RCON <= x"10";
                when 11  => RCON <= x"20";
                when 12  => RCON <= x"20";
                when 13  => RCON <= x"40";
                when others => RCON <= x"00";
            end case;
        end if;
    end process;
COUNTERR <= STD_LOGIC_VECTOR(TO_UNSIGNED(COUNTER, COUNTERR'LENGTH));
end Behavioral;
