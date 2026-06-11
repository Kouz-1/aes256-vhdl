----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 27.02.2026 16:20:25
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: AES_SelfTest - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Self-checking testbench for the fully-pipelined AES core.  Streams 400
-- known-answer test (KAT) vectors through the DUT, accounts for pipeline
-- latency, and compares each output against the expected ciphertext,
-- incrementing PASS_COUNT / FAIL_COUNT and reporting any mismatch.
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
library work;
use work.kat_256_pkg.all;


entity AES_SelfTest is
--  Port ( );
end AES_SelfTest;

architecture Behavioral of AES_SelfTest is
constant CLK_PERIOD     : time    := 10 ns;
    constant N              : integer := 256;
    constant PIPELINE_DEPTH : integer := 15;
    constant NB_TESTS_RUN   : integer := 400;

    signal CLK          : std_logic := '0';
    signal RST          : std_logic := '1';
    signal PLAIN_TEXT   : std_logic_vector(127 downto 0) := (others => '0');
    signal KEY          : std_logic_vector(255 downto 0) := (others => '0');
    signal CIPHER_TEXT  : std_logic_vector(127 downto 0);

    signal PASS_COUNT   : integer := 0;
    signal FAIL_COUNT   : integer := 0;

begin

    CLK <= not CLK after CLK_PERIOD / 2;

    U : entity work.AES_Fully_Pipelined
        Generic map (N => N)
        Port map (
            CLK         => CLK,
            RST         => RST,
            KEY         => KEY,
            PLAIN_TEXT  => PLAIN_TEXT,
            CIPHER_TEXT => CIPHER_TEXT
        );

    process
        variable v_pass : integer := 0;
        variable v_fail : integer := 0;

        -- Helper procedure to check one output
        procedure check(index : integer) is
        begin
            if CIPHER_TEXT = EXPECTED_KAT(index) then
                report "TEST " & integer'image(index) & " : PASS"
                       severity note;
                v_pass := v_pass + 1;
            else
                report "TEST "        & integer'image(index) & " : FAIL"  &
                       " | Expected : " & to_hstring(EXPECTED_KAT(index)) &
                       " | Got      : " & to_hstring(CIPHER_TEXT)
                       severity error;
                v_fail := v_fail + 1;
            end if;
        end procedure;

    begin

        PLAIN_TEXT <= (others => '0');
        KEY        <= (others => '0');

        -- Wait for pipeline to stabilize
        wait for PIPELINE_DEPTH * CLK_PERIOD;

        report "======================================";
        report "AES-256 Self-Test Starting...";
        report "Testing vectors : 0 to " & integer'image(NB_TESTS_RUN - 1);
        report "Pipeline Depth  : " & integer'image(PIPELINE_DEPTH) & " cycles";
        report "======================================";

        -- ------------------------------------------------
        -- PHASE 1 : Fill the pipeline
        -- Feed first PIPELINE_DEPTH vectors, no check yet
        -- ------------------------------------------------
        for i in 0 to PIPELINE_DEPTH - 1 loop
            PLAIN_TEXT <= PLAINTEXT_KAT(i);
            KEY        <= KEY_KAT(i);
            wait for CLK_PERIOD;
        end loop;

        -- ------------------------------------------------
        -- PHASE 2 : Steady state
        -- Feed input[i], check output[i - PIPELINE_DEPTH]
        -- Check happens at rising edge BEFORE applying next input
        -- ------------------------------------------------
        for i in PIPELINE_DEPTH to NB_TESTS_RUN - 1 loop
            -- Output[i - PIPELINE_DEPTH] is now valid ? check it
            check(i - PIPELINE_DEPTH);
            -- Apply next input
            PLAIN_TEXT <= PLAINTEXT_KAT(i);
            KEY        <= KEY_KAT(i);
            wait for CLK_PERIOD;
        end loop;

        -- ------------------------------------------------
        -- PHASE 3 : Flush remaining PIPELINE_DEPTH results
        -- Clear inputs, check last outputs
        -- ------------------------------------------------
        PLAIN_TEXT <= (others => '0');
        KEY        <= (others => '0');

        for i in 0 to PIPELINE_DEPTH - 1 loop
            -- Check output[NB_TESTS_RUN - PIPELINE_DEPTH + i]
            check(NB_TESTS_RUN - PIPELINE_DEPTH + i);
            wait for CLK_PERIOD;
        end loop;

        -- ------------------------------------------------
        -- PHASE 4 : Final report
        -- ------------------------------------------------
        PASS_COUNT <= v_pass;
        FAIL_COUNT <= v_fail;

        report "======================================";
        report "AES-256 Self-Test Complete";
        report "PASSED : " & integer'image(v_pass) & " / " & integer'image(NB_TESTS_RUN);
        report "FAILED : " & integer'image(v_fail) & " / " & integer'image(NB_TESTS_RUN);
        report "======================================";

        if v_fail = 0 then
            report "ALL TESTS PASSED - AES-256 IS CORRECT !"
                   severity note;
        else
            report "SOME TESTS FAILED - CHECK YOUR AES LOGIC !"
                   severity failure;
        end if;

        wait;
    end process;

end Behavioral;