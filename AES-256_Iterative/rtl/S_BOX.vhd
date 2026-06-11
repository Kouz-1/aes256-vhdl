----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Marouane Kouzi
-- 
-- Create Date: 13.02.2026 17:25:44
-- Design Name: AES-256 Hardware Accelerator
-- Module Name: SubBytes - Behavioral
-- Project Name: AES-256 Hardware Accelerator
-- Target Devices: 
-- Tool Versions: 
-- Description: AES SubBytes look-up table.  Maps each input byte to its GF(2^8) inverse
-- followed by an affine transformation, as defined in FIPS-197 Section 5.1.1.
-- Implemented as a 256-entry combinational LUT.
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

entity S_BOX is
    Port (
           State : in STD_LOGIC_VECTOR (7 downto 0);
           S_Box_State : out STD_LOGIC_VECTOR (7 downto 0));
end S_BOX;

architecture Behavioral of S_BOX is

begin
LUT : process(State)
begin
		case State is
			when x"00" => S_Box_State <= x"63";
			when x"01" => S_Box_State <= x"7c";
			when x"02" => S_Box_State <= x"77";
			when x"03" => S_Box_State <= x"7b";
			when x"04" => S_Box_State <= x"f2";
			when x"05" => S_Box_State <= x"6b";
			when x"06" => S_Box_State <= x"6f";
			when x"07" => S_Box_State <= x"c5";
			when x"08" => S_Box_State <= x"30";
			when x"09" => S_Box_State <= x"01";
			when x"0a" => S_Box_State <= x"67";
			when x"0b" => S_Box_State <= x"2b";
			when x"0c" => S_Box_State <= x"fe";
			when x"0d" => S_Box_State <= x"d7";
			when x"0e" => S_Box_State <= x"ab";
			when x"0f" => S_Box_State <= x"76";
			when x"10" => S_Box_State <= x"ca";
			when x"11" => S_Box_State <= x"82";
			when x"12" => S_Box_State <= x"c9";
			when x"13" => S_Box_State <= x"7d";
			when x"14" => S_Box_State <= x"fa";
			when x"15" => S_Box_State <= x"59";
			when x"16" => S_Box_State <= x"47";
			when x"17" => S_Box_State <= x"f0";
			when x"18" => S_Box_State <= x"ad";
			when x"19" => S_Box_State <= x"d4";
			when x"1a" => S_Box_State <= x"a2";
			when x"1b" => S_Box_State <= x"af";
			when x"1c" => S_Box_State <= x"9c";
			when x"1d" => S_Box_State <= x"a4";
			when x"1e" => S_Box_State <= x"72";
			when x"1f" => S_Box_State <= x"c0";
			when x"20" => S_Box_State <= x"b7";
			when x"21" => S_Box_State <= x"fd";
			when x"22" => S_Box_State <= x"93";
			when x"23" => S_Box_State <= x"26";
			when x"24" => S_Box_State <= x"36";
			when x"25" => S_Box_State <= x"3f";
			when x"26" => S_Box_State <= x"f7";
			when x"27" => S_Box_State <= x"cc";
			when x"28" => S_Box_State <= x"34";
			when x"29" => S_Box_State <= x"a5";
			when x"2a" => S_Box_State <= x"e5";
			when x"2b" => S_Box_State <= x"f1";
			when x"2c" => S_Box_State <= x"71";
			when x"2d" => S_Box_State <= x"d8";
			when x"2e" => S_Box_State <= x"31";
			when x"2f" => S_Box_State <= x"15";
			when x"30" => S_Box_State <= x"04";
			when x"31" => S_Box_State <= x"c7";
			when x"32" => S_Box_State <= x"23";
			when x"33" => S_Box_State <= x"c3";
			when x"34" => S_Box_State <= x"18";
			when x"35" => S_Box_State <= x"96";
			when x"36" => S_Box_State <= x"05";
			when x"37" => S_Box_State <= x"9a";
			when x"38" => S_Box_State <= x"07";
			when x"39" => S_Box_State <= x"12";
			when x"3a" => S_Box_State <= x"80";
			when x"3b" => S_Box_State <= x"e2";
			when x"3c" => S_Box_State <= x"eb";
			when x"3d" => S_Box_State <= x"27";
			when x"3e" => S_Box_State <= x"b2";
			when x"3f" => S_Box_State <= x"75";
			when x"40" => S_Box_State <= x"09";
			when x"41" => S_Box_State <= x"83";
			when x"42" => S_Box_State <= x"2c";
			when x"43" => S_Box_State <= x"1a";
			when x"44" => S_Box_State <= x"1b";
			when x"45" => S_Box_State <= x"6e";
			when x"46" => S_Box_State <= x"5a";
			when x"47" => S_Box_State <= x"a0";
			when x"48" => S_Box_State <= x"52";
			when x"49" => S_Box_State <= x"3b";
			when x"4a" => S_Box_State <= x"d6";
			when x"4b" => S_Box_State <= x"b3";
			when x"4c" => S_Box_State <= x"29";
			when x"4d" => S_Box_State <= x"e3";
			when x"4e" => S_Box_State <= x"2f";
			when x"4f" => S_Box_State <= x"84";
			when x"50" => S_Box_State <= x"53";
			when x"51" => S_Box_State <= x"d1";
			when x"52" => S_Box_State <= x"00";
			when x"53" => S_Box_State <= x"ed";
			when x"54" => S_Box_State <= x"20";
			when x"55" => S_Box_State <= x"fc";
			when x"56" => S_Box_State <= x"b1";
			when x"57" => S_Box_State <= x"5b";
			when x"58" => S_Box_State <= x"6a";
			when x"59" => S_Box_State <= x"cb";
			when x"5a" => S_Box_State <= x"be";
			when x"5b" => S_Box_State <= x"39";
			when x"5c" => S_Box_State <= x"4a";
			when x"5d" => S_Box_State <= x"4c";
			when x"5e" => S_Box_State <= x"58";
			when x"5f" => S_Box_State <= x"cf";
			when x"60" => S_Box_State <= x"d0";
			when x"61" => S_Box_State <= x"ef";
			when x"62" => S_Box_State <= x"aa";
			when x"63" => S_Box_State <= x"fb";
			when x"64" => S_Box_State <= x"43";
			when x"65" => S_Box_State <= x"4d";
			when x"66" => S_Box_State <= x"33";
			when x"67" => S_Box_State <= x"85";
			when x"68" => S_Box_State <= x"45";
			when x"69" => S_Box_State <= x"f9";
			when x"6a" => S_Box_State <= x"02";
			when x"6b" => S_Box_State <= x"7f";
			when x"6c" => S_Box_State <= x"50";
			when x"6d" => S_Box_State <= x"3c";
			when x"6e" => S_Box_State <= x"9f";
			when x"6f" => S_Box_State <= x"a8";
			when x"70" => S_Box_State <= x"51";
			when x"71" => S_Box_State <= x"a3";
			when x"72" => S_Box_State <= x"40";
			when x"73" => S_Box_State <= x"8f";
			when x"74" => S_Box_State <= x"92";
			when x"75" => S_Box_State <= x"9d";
			when x"76" => S_Box_State <= x"38";
			when x"77" => S_Box_State <= x"f5";
			when x"78" => S_Box_State <= x"bc";
			when x"79" => S_Box_State <= x"b6";
			when x"7a" => S_Box_State <= x"da";
			when x"7b" => S_Box_State <= x"21";
			when x"7c" => S_Box_State <= x"10";
			when x"7d" => S_Box_State <= x"ff";
			when x"7e" => S_Box_State <= x"f3";
			when x"7f" => S_Box_State <= x"d2";
			when x"80" => S_Box_State <= x"cd";
			when x"81" => S_Box_State <= x"0c";
			when x"82" => S_Box_State <= x"13";
			when x"83" => S_Box_State <= x"ec";
			when x"84" => S_Box_State <= x"5f";
			when x"85" => S_Box_State <= x"97";
			when x"86" => S_Box_State <= x"44";
			when x"87" => S_Box_State <= x"17";
			when x"88" => S_Box_State <= x"c4";
			when x"89" => S_Box_State <= x"a7";
			when x"8a" => S_Box_State <= x"7e";
			when x"8b" => S_Box_State <= x"3d";
			when x"8c" => S_Box_State <= x"64";
			when x"8d" => S_Box_State <= x"5d";
			when x"8e" => S_Box_State <= x"19";
			when x"8f" => S_Box_State <= x"73";
			when x"90" => S_Box_State <= x"60";
			when x"91" => S_Box_State <= x"81";
			when x"92" => S_Box_State <= x"4f";
			when x"93" => S_Box_State <= x"dc";
			when x"94" => S_Box_State <= x"22";
			when x"95" => S_Box_State <= x"2a";
			when x"96" => S_Box_State <= x"90";
			when x"97" => S_Box_State <= x"88";
			when x"98" => S_Box_State <= x"46";
			when x"99" => S_Box_State <= x"ee";
			when x"9a" => S_Box_State <= x"b8";
			when x"9b" => S_Box_State <= x"14";
			when x"9c" => S_Box_State <= x"de";
			when x"9d" => S_Box_State <= x"5e";
			when x"9e" => S_Box_State <= x"0b";
			when x"9f" => S_Box_State <= x"db";
			when x"a0" => S_Box_State <= x"e0";
			when x"a1" => S_Box_State <= x"32";
			when x"a2" => S_Box_State <= x"3a";
			when x"a3" => S_Box_State <= x"0a";
			when x"a4" => S_Box_State <= x"49";
			when x"a5" => S_Box_State <= x"06";
			when x"a6" => S_Box_State <= x"24";
			when x"a7" => S_Box_State <= x"5c";
			when x"a8" => S_Box_State <= x"c2";
			when x"a9" => S_Box_State <= x"d3";
			when x"aa" => S_Box_State <= x"ac";
			when x"ab" => S_Box_State <= x"62";
			when x"ac" => S_Box_State <= x"91";
			when x"ad" => S_Box_State <= x"95";
			when x"ae" => S_Box_State <= x"e4";
			when x"af" => S_Box_State <= x"79";
			when x"b0" => S_Box_State <= x"e7";
			when x"b1" => S_Box_State <= x"c8";
			when x"b2" => S_Box_State <= x"37";
			when x"b3" => S_Box_State <= x"6d";
			when x"b4" => S_Box_State <= x"8d";
			when x"b5" => S_Box_State <= x"d5";
			when x"b6" => S_Box_State <= x"4e";
			when x"b7" => S_Box_State <= x"a9";
			when x"b8" => S_Box_State <= x"6c";
			when x"b9" => S_Box_State <= x"56";
			when x"ba" => S_Box_State <= x"f4";
			when x"bb" => S_Box_State <= x"ea";
			when x"bc" => S_Box_State <= x"65";
			when x"bd" => S_Box_State <= x"7a";
			when x"be" => S_Box_State <= x"ae";
			when x"bf" => S_Box_State <= x"08";
			when x"c0" => S_Box_State <= x"ba";
			when x"c1" => S_Box_State <= x"78";
			when x"c2" => S_Box_State <= x"25";
			when x"c3" => S_Box_State <= x"2e";
			when x"c4" => S_Box_State <= x"1c";
			when x"c5" => S_Box_State <= x"a6";
			when x"c6" => S_Box_State <= x"b4";
			when x"c7" => S_Box_State <= x"c6";
			when x"c8" => S_Box_State <= x"e8";
			when x"c9" => S_Box_State <= x"dd";
			when x"ca" => S_Box_State <= x"74";
			when x"cb" => S_Box_State <= x"1f";
			when x"cc" => S_Box_State <= x"4b";
			when x"cd" => S_Box_State <= x"bd";
			when x"ce" => S_Box_State <= x"8b";
			when x"cf" => S_Box_State <= x"8a";
			when x"d0" => S_Box_State <= x"70";
			when x"d1" => S_Box_State <= x"3e";
			when x"d2" => S_Box_State <= x"b5";
			when x"d3" => S_Box_State <= x"66";
			when x"d4" => S_Box_State <= x"48";
			when x"d5" => S_Box_State <= x"03";
			when x"d6" => S_Box_State <= x"f6";
			when x"d7" => S_Box_State <= x"0e";
			when x"d8" => S_Box_State <= x"61";
			when x"d9" => S_Box_State <= x"35";
			when x"da" => S_Box_State <= x"57";
			when x"db" => S_Box_State <= x"b9";
			when x"dc" => S_Box_State <= x"86";
			when x"dd" => S_Box_State <= x"c1";
			when x"de" => S_Box_State <= x"1d";
			when x"df" => S_Box_State <= x"9e";
			when x"e0" => S_Box_State <= x"e1";
			when x"e1" => S_Box_State <= x"f8";
			when x"e2" => S_Box_State <= x"98";
			when x"e3" => S_Box_State <= x"11";
			when x"e4" => S_Box_State <= x"69";
			when x"e5" => S_Box_State <= x"d9";
			when x"e6" => S_Box_State <= x"8e";
			when x"e7" => S_Box_State <= x"94";
			when x"e8" => S_Box_State <= x"9b";
			when x"e9" => S_Box_State <= x"1e";
			when x"ea" => S_Box_State <= x"87";
			when x"eb" => S_Box_State <= x"e9";
			when x"ec" => S_Box_State <= x"ce";
			when x"ed" => S_Box_State <= x"55";
			when x"ee" => S_Box_State <= x"28";
			when x"ef" => S_Box_State <= x"df";
			when x"f0" => S_Box_State <= x"8c";
			when x"f1" => S_Box_State <= x"a1";
			when x"f2" => S_Box_State <= x"89";
			when x"f3" => S_Box_State <= x"0d";
			when x"f4" => S_Box_State <= x"bf";
			when x"f5" => S_Box_State <= x"e6";
			when x"f6" => S_Box_State <= x"42";
			when x"f7" => S_Box_State <= x"68";
			when x"f8" => S_Box_State <= x"41";
			when x"f9" => S_Box_State <= x"99";
			when x"fa" => S_Box_State <= x"2d";
			when x"fb" => S_Box_State <= x"0f";
			when x"fc" => S_Box_State <= x"b0";
			when x"fd" => S_Box_State <= x"54";
			when x"fe" => S_Box_State <= x"bb";
			when x"ff" => S_Box_State <= x"16";
			when others => null; -- GHDL complains without this statement
		end case;

end process LUT;

end Behavioral;
