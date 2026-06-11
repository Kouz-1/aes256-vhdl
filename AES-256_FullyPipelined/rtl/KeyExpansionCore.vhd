----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: KeyExpansionCore
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Combinational key-schedule core.  Given the current N-bit key and the RCON
-- byte, it derives the next round key using RotWord, SubWord, and XOR
-- operations as specified in FIPS-197 Section 5.2.  Parameterizable for
-- AES-128 (N=128), AES-192 (N=192), and AES-256 (N=256).
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity KeyExpansionCore is
    Generic (N : positive := 256); -- 128 / 192 / 256
    Port (
        KEY      : in  STD_LOGIC_VECTOR (N-1 downto 0);
        RCON     : in  STD_LOGIC_VECTOR (7 downto 0);
        NEXT_KEY : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end KeyExpansionCore;

architecture Behavioral of KeyExpansionCore is

    constant Nk : integer := N / 32; -- 4 / 6 / 8

    signal W0, W1, W2, W3, W4, W5, W6, W7 : STD_LOGIC_VECTOR(31 downto 0);
    signal TEMP           : STD_LOGIC_VECTOR(31 downto 0);
    signal ROT_WORD       : STD_LOGIC_VECTOR(31 downto 0);
    signal SUB_WORD       : STD_LOGIC_VECTOR(31 downto 0);
    signal RCON_WORD      : STD_LOGIC_VECTOR(31 downto 0);
    
    signal NEW_W0, NEW_W1, NEW_W2, NEW_W3, NEW_W4, NEW_W5, NEW_W6, NEW_W7, NEW_WS3 : STD_LOGIC_VECTOR(31 downto 0);

begin



    --===============================================================================

NK4 :  if Nk = 4 generate
    -- Split first 4 words (always exist)
    W0 <= KEY(127 downto 96);   W1 <= KEY(95 downto 64);
    W2 <= KEY(63 downto 32);    W3 <= KEY(31 downto 0);
    

    -- Last word of current key register
    TEMP <= KEY(31 downto 0);
    
    -- RotWord (rotate left 1 byte)
    ROT_WORD <= TEMP(23 downto 0) & TEMP(31 downto 24);

    -- SubWord (4 S-boxes)
    gen_sbox : for i in 0 to 3 generate
        U: entity work.S_BOX
            port map (
                State        => ROT_WORD(8*i+7 downto 8*i),
                S_Box_State  => SUB_WORD(8*i+7 downto 8*i)
            );
    end generate;

    -- Rcon placed in MS byte
    RCON_WORD <= RCON & x"000000";

    -- First new word (AES rule for i mod Nk = 0)
    NEW_W0 <= W0 xor SUB_WORD xor RCON_WORD;

    -- Remaining chained words
    NEW_W1 <= W1 xor NEW_W0;
    NEW_W2 <= W2 xor NEW_W1;
    NEW_W3 <= W3 xor NEW_W2;

    -----------------------------------------------------------------
    -- Output depends on AES version
    -----------------------------------------------------------------
    NEXT_KEY <= NEW_W0 & NEW_W1 & NEW_W2 & NEW_W3;

    end generate NK4;

    --===============================================================================



    --===============================================================================

NK6 :  if Nk = 6 generate
    -- Split first 4 words (always exist)
    W0 <= KEY(191 downto 160);  W1 <= KEY(159 downto 128);
    W2 <= KEY(127 downto 96);   W3 <= KEY(95 downto 64);
    W4 <= KEY(63 downto 32);    W5 <= KEY(31 downto 0);

    -- Last word of current key register
    TEMP <= KEY(31 downto 0);   -- last word = W5
    
    -- RotWord (rotate left 1 byte)
    ROT_WORD <= TEMP(23 downto 0) & TEMP(31 downto 24);

    -- SubWord (4 S-boxes)
    gen_sbox2 : for i in 0 to 3 generate
        U3: entity work.S_BOX
            port map (
                State        => ROT_WORD(8*i+7 downto 8*i),
                S_Box_State  => SUB_WORD(8*i+7 downto 8*i)
            );
    end generate;

    -- Rcon placed in MS byte
    RCON_WORD <= RCON & x"000000";

    -- First new word (AES rule for i mod Nk = 0)
    NEW_W0 <= W0 xor SUB_WORD xor RCON_WORD;

    -- Remaining chained words
    NEW_W1 <= W1 xor NEW_W0;
    NEW_W2 <= W2 xor NEW_W1;
    NEW_W3 <= W3 xor NEW_W2;
    NEW_W4 <= W4 xor NEW_W3;
    NEW_W5 <= W5 xor NEW_W4;
    -----------------------------------------------------------------
    -- Output depends on AES version
    -----------------------------------------------------------------
    NEXT_KEY <= NEW_W0 & NEW_W1 & NEW_W2 & NEW_W3 & NEW_W4 & NEW_W5;

    end generate NK6;

    --===============================================================================



    --===============================================================================

NK8 :  if Nk = 8 generate
    -- Split first 4 words (always exist)
    W0 <= KEY(N-1   downto N-32);
    W1 <= KEY(N-33  downto N-64);
    W2 <= KEY(N-65  downto N-96);
    W3 <= KEY(N-97  downto N-128);
    W4 <= KEY(N-129 downto N-160);
    W5 <= KEY(N-161 downto N-192);
    W6 <= KEY(N-193 downto N-224);
    W7 <= KEY(N-225 downto N-256);
    
    -- Last word of current key register
    TEMP <= KEY(31 downto 0); -- W7, the last word
    
    -- RotWord (rotate left 1 byte)
    ROT_WORD <= TEMP(23 downto 0) & TEMP(31 downto 24);

    -- SubWord (4 S-boxes)
    gen_sboxx : for i in 0 to 3 generate
        U0: entity work.S_BOX
            port map (
                State        => ROT_WORD(8*i+7 downto 8*i),
                S_Box_State  => SUB_WORD(8*i+7 downto 8*i)
            );
    end generate;

    -- Rcon placed in MS byte
    RCON_WORD <= RCON & x"000000";

    -- First new word (AES rule for i mod Nk = 0)
    NEW_W0 <= W0 xor SUB_WORD xor RCON_WORD;

    -- Remaining chained words
    NEW_W1 <= W1 xor NEW_W0;
    NEW_W2 <= W2 xor NEW_W1;
    NEW_W3 <= W3 xor NEW_W2;

gen_sbox3 : for i in 0 to 3 generate
    U1: entity work.S_BOX
            port map (
                State        => NEW_W3(8*i+7 downto 8*i),
                S_Box_State  => NEW_WS3(8*i+7 downto 8*i)
            );
end generate;

    NEW_W4 <= W4 xor NEW_WS3;
    NEW_W5 <= W5 xor NEW_W4;
    NEW_W6 <= W6 xor NEW_W5;
    NEW_W7 <= W7 xor NEW_W6;
    -----------------------------------------------------------------
    -- Output depends on AES version
    -----------------------------------------------------------------
NEXT_KEY <= NEW_W0 & NEW_W1 & NEW_W2 & NEW_W3 &
            NEW_W4 & NEW_W5 & NEW_W6 & NEW_W7;
    end generate NK8;

    --===============================================================================


end Behavioral;