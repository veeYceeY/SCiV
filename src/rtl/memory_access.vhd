----------------------------------------------------------------------------------
-- Company: SCiMOS
-- Engineer: veeYceeY
-- 
-- Create Date: 24.05.2020 13:16:11
-- Design Name: 
-- Module Name: memory_access - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory_access is
  Port ( 
            i_clk : std_logic;
            i_rst : std_logic;
                        
            i_exe_res           : in std_logic_vector(31 downto 0);
            
            i_br_addr           : in std_logic_vector(31 downto 0);
            i_flush             : in std_logic;
            i_mem_fwsel             : in std_logic;
            i_fw_mm             : in std_logic_vector(31 downto 0);
            i_mem_wr_data       : in std_logic_vector(31 downto 0);
            i_mem_addr          : in std_logic_vector(31 downto 0);
            i_mem_we            : in std_logic;
            i_mem_en            : in std_logic;
            i_mem_we_p            : in std_logic;
            i_mem_en_p            : in std_logic;
            i_wb_data_sel       : in std_logic;
            i_wb_reg_sel        : in std_logic_vector(4 downto 0);
            i_wb_we             : in std_logic;
            
            i_load_type         : in std_logic_vector(2 downto 0);
            i_store_type        : in std_logic_vector(1 downto 0);
            
            o_data_mem_en       : out std_logic;
            o_data_mem_we       : out std_logic;
            
            o_data_mem_data     : out std_logic_vector(31 downto 0);
            o_data_mem_addr     : out std_logic_vector(31 downto 0);
            o_data_mem_strobe   : out std_logic_vector(3 downto 0);
            i_data_mem_data     : in std_logic_vector(31 downto 0);
            i_data_mem_valid    : in std_logic;
            
            o_stall             : out std_logic;           
            o_br_addr           : out std_logic_vector(31 downto 0);
            o_br_en             : out std_logic;
                        
            o_fb_data           : out std_logic_vector(31 downto 0);
            o_wb_data           : out std_logic_vector(31 downto 0);
            o_wb_reg_sel        : out std_logic_vector(4 downto 0);
            o_wb_we             : out std_logic
            
            
  );
end memory_access;

architecture Behavioral of memory_access is


signal b_sign : std_logic_vector(7 downto 0);
signal h_sign : std_logic_vector(7 downto 0);

signal t_wb_data : std_logic_vector(31 downto 0);
signal t_wb_reg_sel : std_logic_vector(4 downto 0);
signal t_wb_we : std_logic;
signal wb_data : std_logic_vector(31 downto 0);
signal mem_data_rd : std_logic_vector(31 downto 0);
signal mem_data_wr : std_logic_vector(31 downto 0);

signal mem_strobe_rd : std_logic_vector(3 downto 0);
signal mem_strobe_wr : std_logic_vector(3 downto 0);
signal mem_strobe    : std_logic_vector(3 downto 0);

signal mem_data_rd_sb : std_logic_vector(31 downto 0);
signal mem_data_rd_sh : std_logic_vector(31 downto 0);
signal mem_data_rd_sw : std_logic_vector(31 downto 0);

signal mem_data_wr_sb : std_logic_vector(31 downto 0);
signal mem_data_wr_sh : std_logic_vector(31 downto 0);
signal mem_data_wr_sw : std_logic_vector(31 downto 0);

signal mem_data_rd_ub : std_logic_vector(31 downto 0);
signal mem_data_rd_uh : std_logic_vector(31 downto 0);
signal stall : std_logic;
signal stall_state : std_logic;
signal valid_d1 : std_logic;
signal stall_d0: std_logic;
signal stall_t: std_logic;
begin

b_sign <=   x"00" when i_data_mem_data(7) = '0' else
            x"00";
h_sign <=   x"00" when i_data_mem_data(15) = '0' else
            x"00";


mem_data_rd_sb <= b_sign & b_sign & b_sign & i_data_mem_data(7 downto 0);
mem_data_rd_sh <= b_sign & b_sign & i_data_mem_data(15 downto 0);
mem_data_rd_sw <= i_data_mem_data;

mem_data_rd_ub <= x"000000" & i_data_mem_data(7 downto 0);
mem_data_rd_uh <= x"0000" & i_data_mem_data(15 downto 0);

--mem_data_wr_sb <= i_mem_wr_data;

mem_data_rd <=  mem_data_rd_sb when i_load_type = "000" else
                mem_data_rd_sh when i_load_type = "001" else
                mem_data_rd_sw when i_load_type = "010" else
                mem_data_rd_ub when i_load_type = "011" else
                mem_data_rd_uh when i_load_type = "100" else
                mem_data_rd_sw;
--wb_data<= i_fw_mm when i_mem_fwsel = '1' else wb_data;                
mem_data_wr <= i_fw_mm when i_mem_fwsel = '1' else i_mem_wr_data;
--mem_data_wr <=  mem_data_wr_sb when i_store_type = x"0" else
--                mem_data_wr_sh when i_store_type = x"1" else
--                mem_data_wr_sw when i_store_type = x"2" else
--                mem_data_wr_sw;
                
mem_strobe_wr <= "0001" when i_store_type = "00" else
                 "0011" when i_store_type = "01" else
                 "1111" when i_store_type = "10" else
                 "0000";
                 
mem_strobe_rd <= "0001" when i_load_type = "000" else
                 "0011" when i_load_type = "001" else
                 "1111" when i_load_type = "010" else
                 "0001" when i_load_type = "011" else
                 "0011" when i_load_type = "100" else
                 "0000";
                 
wb_data <= i_exe_res when i_wb_data_sel = '0' else mem_data_rd;
mem_strobe <= mem_strobe_rd when i_mem_we = '0' else mem_strobe_wr;
--wb_data<= i_fw_mm when i_mem_fwsel = '1' else wb_data;
--stall <= '0';--not i_data_mem_valid when i_mem_we = '1';

valid_d1 <= '0' when i_rst ='1' else i_data_mem_valid when rising_edge(i_clk);
process(i_clk,i_rst)
begin
    if i_rst = '1' then
        stall <= '0';
        stall_state <= '0';
    elsif rising_edge(i_clk) then
        if stall_state='0' then
            if i_mem_en_p = '1' and i_flush /='1' then --and i_mem_we_p = '0' then
                stall_state<='1';
                stall <= '1';
            else
                stall <= '0';
            end if;
        else
            if i_data_mem_valid = '1' then
                stall_state<='0';
                stall <= '0';
            else
                stall <= '1';
            end if;
        end if;
    end if;
end process;
stall_t<= stall and (not i_data_mem_valid);
stall_d0 <= stall when rising_edge(i_clk);
o_stall <= stall;
--o_data_mem_en     <= '0'            when i_rst = '1' else i_mem_en          when rising_edge(i_clk);
--o_data_mem_we     <= '0'            when i_rst = '1' else i_mem_we          when rising_edge(i_clk);
--o_data_mem_addr   <= (others =>'0') when i_rst = '1' else i_mem_addr        when rising_edge(i_clk);
--o_data_mem_strobe <= (others =>'0') when i_rst = '1' else mem_strobe        when rising_edge(i_clk);
--o_data_mem_data   <= (others =>'0') when i_rst = '1' else mem_data_wr       when rising_edge(i_clk);
--o_stall           <= '0'            when i_rst = '1' else i_data_mem_valid  when rising_edge(i_clk);
--o_br_addr         <= (others =>'0') when i_rst = '1' else i_br_addr         when rising_edge(i_clk);
--o_br_en           <= '0'            when i_rst = '1' else i_br_en           when rising_edge(i_clk);
--o_wb_data         <= (others =>'0') when i_rst = '1' else wb_data           when rising_edge(i_clk);
--o_wb_reg_sel      <= (others =>'0') when i_rst = '1' else i_wb_reg_sel      when rising_edge(i_clk);
--o_wb_we           <= '0'            when i_rst = '1' else i_wb_we           when rising_edge(i_clk);



process(i_clk,i_rst)
begin
    if i_rst = '1' then
    
        --o_data_mem_en     <= '0'              ;
        --o_data_mem_we     <= '0'              ;
        --o_data_mem_addr   <= (others =>'0')   ;
        --o_data_mem_strobe <= (others =>'0')   ;
        --o_data_mem_data   <= (others =>'0')   ;
        --o_stall           <= '0'              ;
        o_br_addr         <= (others =>'0')   ;
        o_br_en           <= '0'              ;
        o_wb_data         <= (others =>'0')   ;
        o_wb_reg_sel      <= (others =>'0')   ;
        o_wb_we           <= '0'              ;
        
    elsif rising_edge(i_clk) then
            --o_data_mem_en     <= i_mem_en and (not stall_d0);
            --o_data_mem_we     <= i_mem_we          ;
            --o_data_mem_addr   <= i_mem_addr        ;
            --o_data_mem_strobe <= mem_strobe        ;
            --o_data_mem_data   <= mem_data_wr       ;
            
        if stall_t = '0'  then
            --o_stall           <= i_data_mem_valid  ;
            o_fb_data <= wb_data;
            o_br_addr         <= i_br_addr         ;
            o_br_en           <= i_flush           ;
            --t_wb_data         <= wb_data           ;
            --t_wb_reg_sel      <= i_wb_reg_sel      ;
            --t_wb_we           <= i_wb_we        
            o_wb_data         <= wb_data           ;
            o_wb_reg_sel      <= i_wb_reg_sel      ;
            o_wb_we           <= i_wb_we           ;
        end if;
    end if;
end process;
--o_wb_data <= wb_data when i_data_mem_valid ='1' and i_wb_data_sel='1' else t_wb_data ;
--o_wb_reg_sel <= i_wb_reg_sel when i_data_mem_valid ='1' and i_wb_data_sel='1' else t_wb_reg_sel ;
--o_wb_we <= i_wb_we when i_data_mem_valid ='1' and i_wb_data_sel='1' else t_wb_we ;
o_data_mem_en     <= i_mem_en and (not stall_d0);
o_data_mem_we     <= i_mem_we and (not stall_d0);
o_data_mem_addr   <= i_mem_addr        ;
o_data_mem_strobe <= mem_strobe        ;
o_data_mem_data   <= mem_data_wr       ;

end Behavioral;
