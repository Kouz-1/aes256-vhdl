----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 26.02.2026 22:34:37
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: AES_Fully_Pipelined - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: Top-level entity for the fully-pipelined AES core.  Chains InitialRound,
-- 13 Round1 stages, and FinalRound, with a pipeline register between each
-- stage.  Accepts one 128-bit plaintext block per clock cycle once filled.
-- Pipeline depth: ~15 cycles.  Parameterizable for AES-128/192/256 via N.
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

entity AES_Fully_Pipelined is
    Generic (N : integer := 256);
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           PLAIN_TEXT : in STD_LOGIC_VECTOR (127 downto 0);
           KEY : in STD_LOGIC_VECTOR (N-1 downto 0);
           CIPHER_TEXT : out STD_LOGIC_VECTOR (127 downto 0));
end AES_Fully_Pipelined;

architecture Behavioral of AES_Fully_Pipelined is
Signal COUNTERR : STD_LOGIC_VECTOR(3 downto 0);
Signal RCONN : STD_LOGIC_VECTOR (7 downto 0);
Signal FINAL_ROUNDD : STD_LOGIC;
Signal REGT00_IN, REGT00_OUT, REGT0_IN, REGT0_OUT, REGT1_IN, REGT1_OUT, REGT2_IN, REGT2_OUT, REGT3_OUT, REGT3_IN, REGT4_IN, REGT4_OUT, REGT5_IN, REGT5_OUT, REGT6_IN, REGT6_OUT, REGT7_IN, REGT7_OUT, REGT8_IN, REGT8_OUT, REGT9_IN, REGT9_OUT, REGT10_IN, REGT10_OUT, REGT11_IN, REGT11_OUT, REGT12_IN, REGT12_OUT, REGT13_IN, REGT13_OUT : STD_LOGIC_VECTOR(127 downto 0);
Signal REGK00_OUT, REGK0_OUT, REGK1_OUT, REGK2_OUT, REGK3_OUT, REGK4_OUT, REGK5_OUT, REGK6_OUT, REGK7_OUT, REGK8_OUT, REGK9_OUT, REGK10_OUT, REGK11_OUT, REGK12_OUT : STD_LOGIC_VECTOR (N-1 downto 0);
Signal SUBKEY0, SUBKEY1, SUBKEY2, SUBKEY3, SUBKEY4, SUBKEY5, SUBKEY6, SUBKEY7, SUBKEY8, SUBKEY9, SUBKEY10, SUBKEY11, SUBKEY12, SUBKEY13 : STD_LOGIC_VECTOR (N-1 downto 0);
begin


Inst_Controller : entity work.Controller
    Generic map ( N => N)
    Port map (
        CLK => CLK,
        RST => RST,
        RCON => RCONN,
        FINAL_ROUND => FINAL_ROUNDD,
        COUNTERR => COUNTERR
        );
        
Inst_AddRoundKeyInit : entity work.AddRoundKey
    Port map (
        DATA_IN1 => KEY(255 downto 128),
        DATA_IN2 => PLAIN_TEXT,
        DATA_OUT => REGT00_IN
        );
        
Inst_RegistreTexteInit : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT00_IN,
        CLK => CLK,
        DATA_OUT => REGT00_OUT
        );

Inst_RegistreKeyInit : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => KEY,
        CLK => CLK,
        DATA_OUT => REGK00_OUT
        ); 
               
Inst_InitialRound : entity work.InitialRound
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK00_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT00_OUT,
        CIPHER => REGT0_IN,
        SUBKEY => SUBKEY0,
        RCON => x"01"
        );

Inst_RegistreTexte0 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT0_IN,
        CLK => CLK,
        DATA_OUT => REGT0_OUT
        );


Inst_RegistreKey0 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => SUBKEY0,
        CLK => CLK,
        DATA_OUT => REGK0_OUT
        );
        
        
InstRound1 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK0_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT0_OUT,
        CIPHER => REGT1_IN,
        SUBKEY => SUBKEY1,
        RCON => x"01",
        SEL => '0'
        );
        
Inst_RegistreTexte1 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT1_IN,
        CLK => CLK,
        DATA_OUT => REGT1_OUT
        );


Inst_RegistreKey1 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => REGK0_OUT,
        CLK => CLK,
        DATA_OUT => REGK1_OUT
        );
        
        
InstRound2 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK1_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT1_OUT,
        CIPHER => REGT2_IN,
        SUBKEY => SUBKEY2,
        RCON => x"02",
        SEL => '1'
        );
        
        
Inst_RegistreTexte2 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT2_IN,
        CLK => CLK,
        DATA_OUT => REGT2_OUT
        );


Inst_RegistreKey2 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => SUBKEY2,
        CLK => CLK,
        DATA_OUT => REGK2_OUT
        );
        
        
InstRound3 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK2_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT2_OUT,
        CIPHER => REGT3_IN,
        SUBKEY => SUBKEY3,
        RCON => x"02",
        SEL => '0'
        );
        
        
Inst_RegistreTexte3 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT3_IN,
        CLK => CLK,
        DATA_OUT => REGT3_OUT
        );


Inst_RegistreKey3 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => REGK2_OUT,
        CLK => CLK,
        DATA_OUT => REGK3_OUT
        );
        

InstRound4 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK3_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT3_OUT,
        CIPHER => REGT4_IN,
        SUBKEY => SUBKEY4,
        RCON => x"04",
        SEL => '1'
        );
        
        
Inst_RegistreTexte4 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT4_IN,
        CLK => CLK,
        DATA_OUT => REGT4_OUT
        );


Inst_RegistreKey4 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => SUBKEY4,
        CLK => CLK,
        DATA_OUT => REGK4_OUT
        );
        
        
InstRound5 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK4_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT4_OUT,
        CIPHER => REGT5_IN,
        SUBKEY => SUBKEY5,
        RCON => x"04",
        SEL => '0'
        );
        
        
Inst_RegistreTexte5 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT5_IN,
        CLK => CLK,
        DATA_OUT => REGT5_OUT
        );


Inst_RegistreKey5 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => REGK4_OUT,
        CLK => CLK,
        DATA_OUT => REGK5_OUT
        );
        
InstRound6 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK5_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT5_OUT,
        CIPHER => REGT6_IN,
        SUBKEY => SUBKEY6,
        RCON => x"08",
        SEL => '1'
        );
        
        
Inst_RegistreTexte6 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT6_IN,
        CLK => CLK,
        DATA_OUT => REGT6_OUT
        );


Inst_RegistreKey6 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => SUBKEY6,
        CLK => CLK,
        DATA_OUT => REGK6_OUT
        );       
        

InstRound7 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK6_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT6_OUT,
        CIPHER => REGT7_IN,
        SUBKEY => SUBKEY7,
        RCON => x"08",
        SEL => '0'
        );
        
        
Inst_RegistreTexte7 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT7_IN,
        CLK => CLK,
        DATA_OUT => REGT7_OUT
        );


Inst_RegistreKey7 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => REGK6_OUT,
        CLK => CLK,
        DATA_OUT => REGK7_OUT
        ); 
        
        
InstRound8 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK7_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT7_OUT,
        CIPHER => REGT8_IN,
        SUBKEY => SUBKEY8,
        RCON => x"10",
        SEL => '1'
        );
        
        
Inst_RegistreTexte8 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT8_IN,
        CLK => CLK,
        DATA_OUT => REGT8_OUT
        );


Inst_RegistreKey8 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => SUBKEY8,
        CLK => CLK,
        DATA_OUT => REGK8_OUT
        ); 
        
        
            
InstRound9 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK8_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT8_OUT,
        CIPHER => REGT9_IN,
        SUBKEY => SUBKEY9,
        RCON => x"10",
        SEL => '0'
        );
        
        
Inst_RegistreTexte9 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT9_IN,
        CLK => CLK,
        DATA_OUT => REGT9_OUT
        );


Inst_RegistreKey9 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => REGK8_OUT,
        CLK => CLK,
        DATA_OUT => REGK9_OUT
        );
        
        
InstRound10 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK9_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT9_OUT,
        CIPHER => REGT10_IN,
        SUBKEY => SUBKEY10,
        RCON => x"20",
        SEL => '1'
        );
        
        
Inst_RegistreTexte10 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT10_IN,
        CLK => CLK,
        DATA_OUT => REGT10_OUT
        );


Inst_RegistreKey10 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => SUBKEY10,
        CLK => CLK,
        DATA_OUT => REGK10_OUT
        );
        
        
        
InstRound11 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK10_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT10_OUT,
        CIPHER => REGT11_IN,
        SUBKEY => SUBKEY11,
        RCON => x"20",
        SEL => '0'
        );
        
        
Inst_RegistreTexte11 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT11_IN,
        CLK => CLK,
        DATA_OUT => REGT11_OUT
        );


Inst_RegistreKey11 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => REGK10_OUT,
        CLK => CLK,
        DATA_OUT => REGK11_OUT
        );
 

InstRound12 : entity work.Round1
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK11_OUT,
        FINAL_ROUND => FINAL_ROUNDD,
        PLAIN_TEXT => REGT11_OUT,
        CIPHER => REGT12_IN,
        SUBKEY => SUBKEY12,
        RCON => x"40",
        SEL => '1'
        );
        
        
Inst_RegistreTexte12 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT12_IN,
        CLK => CLK,
        DATA_OUT => REGT12_OUT
        );


Inst_RegistreKey12 : entity work.Registre
    Generic map ( SIZE => N)
    Port map (
        DATA_IN => SUBKEY12,
        CLK => CLK,
        DATA_OUT => REGK12_OUT
        );  

InstRoundFinal : entity work.FinalRound
    Generic map ( N => N)
    Port map (
        RST => RST,
        KEY => REGK12_OUT,
        PLAIN_TEXT => REGT12_OUT,
        CIPHER => REGT13_IN
        );
        
Inst_RegistreTexte13 : entity work.Registre
    Generic map ( SIZE => 128)
    Port map (
        DATA_IN => REGT13_IN,
        CLK => CLK,
        DATA_OUT => REGT13_OUT
        );
        
CIPHER_TEXT <= REGT13_OUT;        
end Behavioral;
