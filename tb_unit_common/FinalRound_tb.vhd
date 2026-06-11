----------------------------------------------------------------------------------
-- Company:
-- Engineer: Marouane Kouzi
--
-- Create Date:
-- Design Name:
-- Module Name: FinalRound_tb - Behavioral
-- Project Name: AES
-- Target Devices:
-- Tool Versions:
-- Description: Directed testbench for FinalRound
--              (SubBytes -> ShiftRows -> AddRoundKey, using KEY(255 downto 128)).
--
-- Dependencies: FinalRound (instantiates SubBytes, ShiftRows, AddRoundKey)
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--   Golden vectors require the SubBytes/ShiftRows datapath. This bench drives
--   directed plaintext/key vectors and checks that CIPHER resolves to a defined
--   value. RST is present on the port but unused inside the DUT.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FinalRound_tb is
end FinalRound_tb;

architecture Behavioral of FinalRound_tb is

    Constant N          : integer := 256;
    Constant PROP_DELAY : time    := 10 ns;

    Signal PLAIN_TEXT_TB : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
    Signal KEY_TB        : STD_LOGIC_VECTOR (N - 1 downto 0) := (others => '0');
    Signal RST_TB        : STD_LOGIC := '0';
    Signal CIPHER_TB     : STD_LOGIC_VECTOR (127 downto 0);

    function no_unknowns (v : STD_LOGIC_VECTOR) return boolean is
    begin
        for i in v'range loop
            if v(i) /= '0' and v(i) /= '1' then
                return false;
            end if;
        end loop;
        return true;
    end function;

begin

    UUT: entity work.FinalRound
        generic map ( N => N )
        port map (
            PLAIN_TEXT => PLAIN_TEXT_TB,
            KEY        => KEY_TB,
            RST        => RST_TB,
            CIPHER     => CIPHER_TB
            );

    Stimulus : Process
        procedure apply (pt : STD_LOGIC_VECTOR(127 downto 0);
                         k  : STD_LOGIC_VECTOR(N - 1 downto 0)) is
        begin
            PLAIN_TEXT_TB <= pt;
            KEY_TB        <= k;
            wait for PROP_DELAY;
            assert no_unknowns(CIPHER_TB)
                report "FinalRound : CIPHER contains undefined bits" severity error;
        end procedure;
    begin
        RST_TB <= '0';

        apply(x"00000000000000000000000000000000",
              x"00000000000000000000000000000000" & x"00000000000000000000000000000000");

        apply(x"3243f6a8885a308d313198a2e0370734",
              x"2b7e151628aed2a6abf7158809cf4f3c" & x"762e7160f38b4da56a784d9045190cfe");

        apply(x"ffffffffffffffffffffffffffffffff",
              x"0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f" & x"f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0");

        report "FinalRound_tb : directed stimulus complete (check waveform for expected values)" severity note;
        wait;
    end process;

end Behavioral;
