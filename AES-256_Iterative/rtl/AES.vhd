----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 22.02.2026 15:26:42
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: AES - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Top-level entity for the iterative AES core.  A single round datapath is
-- reused over 14 clock cycles under control of the Counter/FSM.
-- MUX and MUXK select between the initial input and the fed-back state.
-- Latency: 14 cycles per 128-bit block.  Parameterizable via generic N.
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

entity AES is
    Generic ( N : integer := 256);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           FINAL_ROUNDD : out STD_LOGIC;
           KEY : in STD_LOGIC_VECTOR (N-1 downto 0);
           PLAIN_TEXT : in STD_LOGIC_VECTOR (127 downto 0);
           CIPHER_TEXT : out STD_LOGIC_VECTOR (127 downto 0);
           CIPHER_TEXT2 : out STD_LOGIC_VECTOR (127 downto 0));
end AES;

architecture Behavioral of AES is

Signal FINAL_ROUND, LOAD : STD_LOGIC;
Signal RCON : STD_LOGIC_VECTOR(7 downto 0);
Signal CIPHER : STD_LOGIC_VECTOR(127 downto 0);
Signal REGT_OUT, NextMain, REGT_OUT2 : STD_LOGIC_VECTOR(127 downto 0);
Signal NEXT_KEY, REGK_OUT, REGK_OUT2, MUXKIN : STD_LOGIC_VECTOR(N-1 downto 0);
Signal X : STD_LOGIC_VECTOR(127 downto 0);
Signal KeyExpansion_IN : STD_LOGIC_VECTOR(N-1 downto 0);
Signal MainRound_IN : STD_LOGIC_VECTOR(127 downto 0);
Signal COUNTER : STD_LOGIC_VECTOR(3 downto 0);
Signal TEMP_TEXT, K : STD_LOGIC_VECTOR(127 downto 0);

begin

Inst_InitialRound: entity work.InitialRound 
    Generic map ( N => N)
    Port map (
        RST => RST,
        FINAL_ROUND => FINAL_ROUND,
        KEY => KEY,
        PLAIN_TEXT => PLAIN_TEXT,
        CIPHER_TEXT => CIPHER
        );

Inst_Controller : entity work.Controller
    Generic map ( N => N)
    Port map (
        RST => RST,
        CLK => CLK,
        RCON => RCON,
        FINAL_ROUND => FINAL_ROUND,
        COUNTERR => COUNTER
        );
        
Inst_RegistreT : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => CIPHER,
        DATA_OUT => REGT_OUT,
        CLK => CLK
        );

        
Inst_RegistreK : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => KEY,
        DATA_OUT => REGK_OUT,
        CLK => CLK
        );
        
           
Inst_KeyExpansion : entity work.KeyExpansion
    Generic map ( N => N)
    Port map ( 
        RST => RST,
        RCON => RCON,
        KEY => KeyExpansion_IN,
        NEXT_KEY => NEXT_KEY
        );

Inst_Registre_KeyExpansion : entity work.RegistreLoad
    Port map (
        DATA_IN => NEXT_KEY,
        DATA_OUT => MUXKIN,
        CLK => CLK,
        LOAD => LOAD
        );
        
Ins_MUXSpecial : entity work.MUXSpecial
    Port map (
        DATA_IN => MUXKIN,
        DATA_OUT => K,
        SEL => LOAD
        );
        
        
Inst_MainRound : entity work.MainRound
    Generic map ( N => N)
    Port map ( 
    RST => RST,
    FINAL_ROUND => FINAL_ROUND,
    PLAIN_TEXT => MainRound_IN,
    CIPHER_TEXT => X
    );
    
--Inst_Registre_MainRound : entity work.Registre
  --  Generic map ( SIZE => 128)
    --Port map (
      --  DATA_IN => X,
        --DATA_OUT => TEMP_TEXT,
      --  CLK => CLK
        --);
        
Inst_AddRoundKey1 : entity work.AddRoundKey
    Port map (
        DATA_IN1 => X,
        DATA_IN2 => K,
        DATA_OUT => NextMain
        );

        
Inst_RegistreK2 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => MUXKIN,
        DATA_OUT => REGK_OUT2,
        CLK => CLK
        );
        
Inst_RegistreT2 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => NextMain,
        DATA_OUT => REGT_OUT2,
        CLK => CLK
        );
        
Inst_MUXT : entity work.MUX 
    Generic map ( TAILLE => 128)
    Port map (
        DATA_IN1 => REGT_OUT,
        DATA_IN2 => REGT_OUT2,
        COUNTER => COUNTER,
        DATA_OUT => MainRound_IN
        );
        
Inst_MUXK : entity work.MUXK 
    Generic map ( TAILLE => 256)
    Port map (
        DATA_IN1 => REGK_OUT,
        DATA_IN2 => REGK_OUT2,
        COUNTER => COUNTER,
        DATA_OUT => KeyExpansion_IN
        );
        
FINAL_ROUNDD <= FINAL_ROUND;
CIPHER_TEXT2 <= NextMain;

end Behavioral;
