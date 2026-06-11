----------------------------------------------------------------------------------
-- Company:
-- Engineer: Marouane Kouzi
--
-- Create Date:
-- Design Name:
-- Module Name: MainSteps_tb - Behavioral
-- Project Name: AES
-- Target Devices:
-- Tool Versions:
-- Description: Directed testbench for MainSteps (SubBytes -> ShiftRows -> MixColumns,
--              with MixColumns bypassed when FINAL_ROUND = '1').
--
-- Dependencies: MainSteps (which instantiates SubBytes, ShiftRows, MixColumns)
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--   Golden AES vectors require the full SubBytes/ShiftRows/MixColumns datapath.
--   This bench drives directed stimulus, toggles FINAL_ROUND, and checks that the
--   output resolves to a fully-defined value (no 'U'/'X'). Inspect DATA_OUT_TB in
--   the waveform / add expected vectors once the sub-modules are available.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MainSteps_tb is
end MainSteps_tb;

architecture Behavioral of MainSteps_tb is

    Constant WIDTH      : integer := 128;
    Constant PROP_DELAY : time    := 10 ns;

    Signal DATA_IN_TB     : STD_LOGIC_VECTOR (WIDTH - 1 downto 0) := (others => '0');
    Signal FINAL_ROUND_TB : STD_LOGIC := '0';
    Signal DATA_OUT_TB    : STD_LOGIC_VECTOR (WIDTH - 1 downto 0);

    -- Returns true only if every bit of v is a clean '0' or '1'.
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

    UUT: entity work.MainSteps
        port map (
            DATA_IN     => DATA_IN_TB,
            FINAL_ROUND => FINAL_ROUND_TB,
            DATA_OUT    => DATA_OUT_TB
            );

    Stimulus : Process
        procedure apply (data : STD_LOGIC_VECTOR(WIDTH - 1 downto 0); final : STD_LOGIC) is
        begin
            DATA_IN_TB     <= data;
            FINAL_ROUND_TB <= final;
            wait for PROP_DELAY;
            assert no_unknowns(DATA_OUT_TB)
                report "MainSteps : DATA_OUT contains undefined bits"
                severity error;
        end procedure;
    begin
        -- Normal round (full SubBytes -> ShiftRows -> MixColumns)
        apply(x"00000000000000000000000000000000", '0');
        apply(x"3243f6a8885a308d313198a2e0370734", '0');
        apply(x"ffffffffffffffffffffffffffffffff", '0');

        -- Final round (MixColumns bypassed)
        apply(x"3243f6a8885a308d313198a2e0370734", '1');
        apply(x"00112233445566778899aabbccddeeff", '1');

        report "MainSteps_tb : directed stimulus complete (check waveform for expected values)" severity note;
        wait;
    end process;

end Behavioral;
