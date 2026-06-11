----------------------------------------------------------------------------------
-- Company:
-- Engineer: Marouane Kouzi
--
-- Create Date:
-- Design Name:
-- Module Name: AddRoundKey_tb - Behavioral
-- Project Name: AES
-- Target Devices:
-- Tool Versions:
-- Description: Self-checking testbench for AddRoundKey (DATA_OUT = DATA_IN1 XOR DATA_IN2)
--
-- Dependencies: AddRoundKey
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AddRoundKey_tb is
end AddRoundKey_tb;

architecture Behavioral of AddRoundKey_tb is

    Constant WIDTH      : integer := 128;
    Constant PROP_DELAY : time    := 5 ns;  -- settling time for the combinational logic

    Signal DATA_IN1_TB : STD_LOGIC_VECTOR (WIDTH - 1 downto 0) := (others => '0');
    Signal DATA_IN2_TB : STD_LOGIC_VECTOR (WIDTH - 1 downto 0) := (others => '0');
    Signal DATA_OUT_TB : STD_LOGIC_VECTOR (WIDTH - 1 downto 0);

    Signal error_count : integer := 0;

begin

    UUT: entity work.AddRoundKey
        port map (
            DATA_IN1 => DATA_IN1_TB,
            DATA_IN2 => DATA_IN2_TB,
            DATA_OUT => DATA_OUT_TB
            );

    Stimulus : Process
        -- Apply one pair of operands and check DATA_OUT against the golden XOR.
        procedure check (a, b : STD_LOGIC_VECTOR(WIDTH - 1 downto 0)) is
        begin
            DATA_IN1_TB <= a;
            DATA_IN2_TB <= b;
            wait for PROP_DELAY;
            assert DATA_OUT_TB = (a xor b)
                report "AddRoundKey mismatch: DATA_OUT /= DATA_IN1 XOR DATA_IN2"
                severity error;
            if DATA_OUT_TB /= (a xor b) then
                error_count <= error_count + 1;
            end if;
        end procedure;
    begin
        -- Test 1 : XOR with all zeros -> identity (output = DATA_IN1)
        check(x"00112233445566778899aabbccddeeff", x"00000000000000000000000000000000");

        -- Test 2 : XOR of a value with itself -> all zeros
        check(x"0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f", x"0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f");

        -- Test 3 : XOR with all ones -> bitwise complement
        check(x"a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5a5", x"ffffffffffffffffffffffffffffffff");

        -- Test 4 : AES round example (arbitrary state and round key)
        check(x"3243f6a8885a308d313198a2e0370734", x"2b7e151628aed2a6abf7158809cf4f3c");

        if error_count = 0 then
            report "AddRoundKey_tb : PASSED (all vectors matched)" severity note;
        else
            report "AddRoundKey_tb : FAILED with " & integer'image(error_count) & " mismatch(es)" severity error;
        end if;

        wait; -- end of simulation
    end process;

end Behavioral;
