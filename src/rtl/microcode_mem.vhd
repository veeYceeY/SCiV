----------------------------------------------------------------------------------
-- Company: SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: 24.04.2020 14:55:58
-- Design Name: 
-- Module Name: microcode_mem - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


 
library ieee;
library work;
use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity microcode_mem is
  Port (
        i_addr : in std_logic_vector(7 downto 0);
        o_code : out std_logic_vector(31 downto 0)
        );
  
end microcode_mem;

architecture Behavioral of microcode_mem is
type type_mem is array(64 downto 0) of std_logic_vector(31 downto 0);
signal u_mem : type_mem;
begin



o_code <= u_mem(to_integer(unsigned(i_addr)));

u_mem(0 )  <= "00000" & "000000000000000000000000000";
u_mem(1 )  <= "00000" & "100111000000000000000000100";
u_mem(2 )  <= "00000" & "100101100000000000000000100";
u_mem(3 )  <= "00000" & "110101000000111001000000100";
u_mem(4 )  <= "00000" & "111000000000111001000000100";
u_mem(5 )  <= "00000" & "111100000000000001000000000";
u_mem(6 )  <= "00000" & "111100000000000011000000000";
u_mem(7 )  <= "00000" & "111100000000000101000000000";
u_mem(8 )  <= "00000" & "111100000000000111000000000";
u_mem(9 )  <= "00000" & "011100000000000101000000000";
u_mem(10)  <= "00000" & "011100000000000111000000000";
u_mem(11)  <= "00000" & "101001000000000000000011100";
u_mem(12)  <= "00000" & "101001000000000000001011100";
u_mem(13)  <= "00000" & "101001000000000000010011100";
u_mem(14)  <= "00000" & "001001000000000000011011100";
u_mem(15)  <= "00000" & "001001000000000000100011100";
u_mem(16)  <= "00000" & "111001000000000000000110000";
u_mem(17)  <= "00000" & "111001000000000000000110001";
u_mem(18)  <= "00000" & "111001000000000000000110010";
u_mem(19)  <= "00000" & "101001000000000000000000100";
u_mem(20)  <= "00000" & "101001000011000000000000100";
u_mem(21)  <= "00000" & "001001000011000000000000100";
u_mem(22)  <= "00000" & "001001000100000000000000100";
u_mem(23)  <= "00000" & "001001000110000000000000100";
u_mem(24)  <= "00000" & "001001001000000000000000100";
u_mem(25)  <= "00000" & "001000001010000000000000100";
u_mem(26)  <= "00000" & "001000001100000000000000100";
u_mem(27)  <= "00000" & "001000001110000000000000100";
u_mem(28)  <= "00000" & "000000000000000000000000100";
u_mem(29)  <= "00000" & "000000000010000000000000100";
u_mem(30)  <= "00000" & "000000001010000000000000100";
u_mem(31)  <= "00000" & "000000000001000000000000100";
u_mem(32)  <= "00000" & "100000000001000000000000100";
u_mem(33)  <= "00000" & "000000000100000000000000100";
u_mem(34)  <= "00000" & "000000001100000000000000100";
u_mem(35)  <= "00000" & "000000001110000000000000100";
u_mem(36)  <= "00000" & "000000001000000000000000100";
u_mem(37)  <= "00000" & "000000000110000000000000100";
u_mem(38)  <= "00000" & "000000000000000000000000000";
u_mem(39)  <= "00000" & "000000000000000000000000000";
u_mem(40)  <= "00000" & "000000000000000000000000000";
u_mem(41)  <= "00000" & "000000000000000000000000000";
                        

end Behavioral;


