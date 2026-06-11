----------------------------------------------------------------------------------
-- Company:
-- Engineer: Marouane Kouzi
--
-- Create Date:
-- Design Name:
-- Module Name: S_BOX_tb - Behavioral
-- Project Name: AES
-- Target Devices:
-- Tool Versions:
-- Description: Self-checking testbench for the AES S-box (byte substitution).
--              Expected values are taken from the FIPS-197 AES S-box.
--
-- Dependencies: S_BOX
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity S_BOX_tb is
end S_BOX_tb;

architecture Behavioral of S_BOX_tb is

    Constant PROP_DELAY : time := 5 ns;  -- settling time for the LUT

    Signal State_TB       : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    Signal S_Box_State_TB : STD_LOGIC_VECTOR (7 downto 0);

    Signal error_count : integer := 0;
    Signal test_index  : integer := 0;

begin

    UUT: entity work.S_BOX
        port map (
            State       => State_TB,
            S_Box_State => S_Box_State_TB
            );

    Stimulus : Process
        -- Drive one input byte and compare the substitution to the expected byte.
        procedure check (input_byte, expected : STD_LOGIC_VECTOR(7 downto 0)) is
        begin
            test_index <= test_index + 1;
            State_TB <= input_byte;
            wait for PROP_DELAY;
            assert S_Box_State_TB = expected
                report "S_BOX mismatch at test #" & integer'image(test_index)
                severity error;
            if S_Box_State_TB /= expected then
                error_count <= error_count + 1;
            end if;
        end procedure;
    begin
        -- A spread of golden mappings from the FIPS-197 AES S-box
        check(x"00", x"63");   -- first entry
        check(x"01", x"7c");
        check(x"0f", x"76");
        check(x"10", x"ca");
        check(x"53", x"ed");
        check(x"7f", x"d2");
        check(x"80", x"cd");
        check(x"a5", x"06");
        check(x"c0", x"ba");
        check(x"f0", x"8c");
        check(x"fe", x"bb");
        check(x"ff", x"16");   -- last entry

        if error_count = 0 then
            report "S_BOX_tb : PASSED (all vectors matched)" severity note;
        else
            report "S_BOX_tb : FAILED with " & integer'image(error_count) & " mismatch(es)" severity error;
        end if;

        wait; -- end of simulation
    end process;

end Behavioral;
