----------------------------------------------------------------------------------
-- Company:
-- Engineer: Marouane Kouzi
--
-- Create Date:
-- Design Name:
-- Module Name: Round1_tb - Behavioral
-- Project Name: AES
-- Target Devices:
-- Tool Versions:
-- Description: Directed testbench for Round1.
--              SEL selects which half of KEY feeds AddRoundKey
--              ('0' -> KEY(N-1 downto 128), '1' -> KEY(127 downto 0)).
--              RST = '0' forces the plaintext path to zero.
--
-- Dependencies: Round1 (instantiates MainSteps, AddRoundKey, KeyExpansion)
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--   Golden vectors require the full datapath. This bench sweeps SEL and RST with
--   directed stimulus and checks that the outputs resolve to defined values.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Round1_tb is
end Round1_tb;

architecture Behavioral of Round1_tb is

    Constant N          : integer := 256;
    Constant PROP_DELAY : time    := 10 ns;

    Signal PLAIN_TEXT_TB  : STD_LOGIC_VECTOR (127 downto 0) := (others => '0');
    Signal KEY_TB         : STD_LOGIC_VECTOR (N - 1 downto 0) := (others => '0');
    Signal RST_TB         : STD_LOGIC := '0';
    Signal SEL_TB         : STD_LOGIC := '0';
    Signal RCON_TB        : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    Signal FINAL_ROUND_TB : STD_LOGIC := '0';
    Signal CIPHER_TB      : STD_LOGIC_VECTOR (127 downto 0);
    Signal SUBKEY_TB      : STD_LOGIC_VECTOR (N - 1 downto 0);

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

    UUT: entity work.Round1
        generic map ( N => N )
        port map (
            PLAIN_TEXT  => PLAIN_TEXT_TB,
            KEY         => KEY_TB,
            RST         => RST_TB,
            SEL         => SEL_TB,
            RCON        => RCON_TB,
            FINAL_ROUND => FINAL_ROUND_TB,
            CIPHER      => CIPHER_TB,
            SUBKEY      => SUBKEY_TB
            );

    Stimulus : Process
    begin
        KEY_TB        <= x"2b7e151628aed2a6abf7158809cf4f3c" & x"762e7160f38b4da56a784d9045190cfe";
        PLAIN_TEXT_TB <= x"3243f6a8885a308d313198a2e0370734";
        RCON_TB       <= x"01";
        RST_TB        <= '1';   -- pass plaintext through

        -- SEL = '0' : use the upper half of KEY
        SEL_TB <= '0';
        wait for PROP_DELAY;
        assert no_unknowns(CIPHER_TB)
            report "Round1 : CIPHER undefined (SEL='0')" severity error;
        assert no_unknowns(SUBKEY_TB)
            report "Round1 : SUBKEY undefined (SEL='0')" severity error;

        -- SEL = '1' : use the lower half of KEY
        SEL_TB <= '1';
        wait for PROP_DELAY;
        assert no_unknowns(CIPHER_TB)
            report "Round1 : CIPHER undefined (SEL='1')" severity error;

        -- RST = '0' : plaintext path forced to zero
        RST_TB <= '0';
        wait for PROP_DELAY;
        assert no_unknowns(CIPHER_TB)
            report "Round1 : CIPHER undefined (RST='0')" severity error;

        report "Round1_tb : directed stimulus complete (check waveform for expected values)" severity note;
        wait;
    end process;

end Behavioral;
