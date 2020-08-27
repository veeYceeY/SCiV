library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;


entity code_mem is
    port(
            i_en : in std_logic;
            i_addr : in std_logic_vector(31 downto 0);
            o_data : out std_logic_vector(31 downto 0);
            o_valid: out std_logic
    );

end code_mem;

architecture behave of code_mem is
type mem_type is array(63 downto 0) of std_logic_vector(31 downto 0);
signal mem : mem_type;

begin

--     --        
     
-- mem(0) <= x"00044" & "00100" & "0110111";--LUI r1,#00044000h
-- mem(1) <= x"00032" & "00101" & "0110111";--LUI r2,#00032000h
-- mem(2) <= "0000000" & "01100" &"00100" &"101" & "00100" & "0010011";--srlI R1,12
-- mem(3) <= "0000000" & "01100" &"00101" &"101" & "00101" & "0010011";--srlI R2,12
-- mem(4) <= "0000000" & "00101" &"00100" &"000" & "00011" & "0110011";--ADD r3,r1,r2
-- mem(5) <= x"0000a" & "00001" & "0110111";--LUI r1,#00044000h
-- mem(6) <= x"00003" & "00010" & "0110111";--LUI r2,#00032000h
-- mem(7) <= "0000000" & "01100" &"00001" &"101" & "00001" & "0010011";--srlI R1,12
-- mem(8) <= "0000000" & "01100" &"00010" &"101" & "00010" & "0010011";--srlI R2,12
-- mem(9) <= x"0000f" & "00100" & "0110111";--LUI r4,0x0000a000
-- mem(10)<= x"00002" & "00101" & "0110111";--LUI r5,0x00004000
-- mem(11)<= x"00001" & "00110" & "0110111";--LUI r6,0x00001000
-- mem(12)<= "0000000" & "01100" &"00100" &"101" & "00100" & "0010011";--srlI R4,12
-- mem(13)<= "0000000" & "01100" &"00101" &"101" & "00101" & "0010011";--srlI R5,12
-- mem(14) <="0000000" & "01100" &"00110" &"101" & "00110" & "0010011";--srlI R6,12
-- mem(15) <= "0100000" & "00110" &"00100" &"000" & "00100" & "0110011";--sub r4,r4,r6
-- mem(16) <= "1111111" & "00100" &"00101" &"100" & "11101" & "1100011";--blt r4,r5,-1
-- mem(17) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
-- mem(18) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
-- mem(19) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
-- mem(20) <= "0000000" & "10000" &"10000" &"000" & "00000" & "0110011";
-- mem(21) <= "0000000" & "00011" &"00000" &"010" & "00110" & "0100011";
-- mem(22) <= "0000000" & "00001" &"00000" &"010" & "00011" & "0100011";
-- mem(23) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(24) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(25) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(26) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(27) <= "0000000" & "00110" &"00000" &"010" & "01001" & "0000011";
-- mem(28) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(29) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(30) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(31) <= "0000000" & "00000" &"00000" &"000" & "00000" & "1100011";--beq r4,r5,-1
-- mem(32) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(33) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(34) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";
-- mem(35) <= "0000000" & "00000" &"00000" &"000" & "00000" & "0110011";


mem(0) <= x"03000413";

mem(1) <= x"04000793";
mem(2) <= x"fef42623";

mem(3) <= x"04400793";
mem(4) <= x"fef42423";

mem(5) <= x"04800793";
mem(6) <= x"fef42223";

mem(7) <= x"fe842783";
mem(8) <= x"00a00713";
mem(9) <= x"00e7a023";

mem(10)<= x"fec42783";
mem(11)<= x"00300713";
mem(12)<= x"00e7a023";

mem(13)<= x"fec42783";
mem(14)<= x"0007a703";
mem(15)<= x"fe842783";
mem(16)<= x"0007a783";
mem(17)<= x"00f70733";
mem(18)<= x"fe442783";
mem(19)<= x"00e7a023";
mem(20)<= x"0000006f";
mem(21)<= x"0000006f";
mem(22)<= x"0000006f";
mem(23)<= x"0000006f";
mem(24)<= x"0000006f";
mem(25)<= x"0000006f";
mem(26)<= x"0000006f";
mem(27)<= x"0000006f";
mem(28)<= x"0000006f";
mem(29)<= x"0000006f";
mem(30)<= x"0000006f";
mem(31)<= x"0000006f";
mem(32)<= x"0000006f";
mem(33)<= x"0000006f";
mem(34)<= x"0000006f";
mem(35)<= x"0000006f";
mem(36)<= x"0000006f";
mem(37)<= x"0000006f";
mem(38)<= x"0000006f";
mem(39)<= x"0000006f";

    o_data <= mem(to_integer(unsigned(( i_addr(31 downto 2)))));
    o_valid<='1';
end behave;

--   10114:	01000793          	li	a5,16
--   10118:	fef42623          	sw	a5,-20(s0)
--   1011c:	01400793          	li	a5,20
--   10120:	fef42423          	sw	a5,-24(s0)
--   10124:	01800793          	li	a5,24
--   10128:	fef42223          	sw	a5,-28(s0)
--   1012c:	fe842783          	lw	a5,-24(s0)
--   10130:	00a00713          	li	a4,10
--   10134:	00e7a023          	sw	a4,0(a5)
--   10138:	fec42783          	lw	a5,-20(s0)
--   1013c:	00300713          	li	a4,3
--   10140:	00e7a023          	sw	a4,0(a5)
--   10144:	fec42783          	lw	a5,-20(s0)
--   10148:	0007a703          	lw	a4,0(a5)
--   1014c:	fe842783          	lw	a5,-24(s0)
--   10150:	0007a783          	lw	a5,0(a5)
--   10154:	00f70733          	add	a4,a4,a5
--   10158:	fe442783          	lw	a5,-28(s0)
--   1015c:	00e7a023          	sw	a4,0(a5)
--   10160:	0000006f          	j	10160 <main+0
