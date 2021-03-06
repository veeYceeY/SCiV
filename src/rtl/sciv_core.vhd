----------------------------------------------------------------------------------
-- Company:  SCiMOS
-- Engineer: Veeyceey
-- 
-- Create Date: 24.05.2020 12:49:36
-- Design Name: 
-- Module Name: sciv_core - Behavioral
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

entity sciv_core is
  Port ( 
            i_clk             : in std_logic;
            i_rst             : in std_logic;
            
            i_irq             : in std_logic;
            o_ack             : out std_logic;
            
            o_data_mem_en     : out std_logic;
            o_data_mem_we     : out std_logic;
            o_data_mem_addr   : out std_logic_vector(31 downto 0);
            i_data_mem_data   : in std_logic_vector(31 downto 0);
            i_data_mem_valid  : in std_logic;
            o_data_mem_data   : out std_logic_vector(31 downto 0);
            o_data_mem_strobe : out std_logic_vector(3 downto 0);
            
            o_code_mem_en     : out std_logic;
            o_code_mem_addr   : out std_logic_vector(31 downto 0);
            i_code_mem_data   : in std_logic_vector(31 downto 0);
            i_code_mem_valid  : in std_logic
            
            
  );
end sciv_core;

architecture Behavioral of sciv_core is
signal ma0_stall : std_logic;

signal wb0_branch_addr : std_logic_vector(31 downto 0);
signal wb0_branch_en : std_logic;

signal fe0_pc : std_logic_vector(31 downto 0);
signal fe0_instr : std_logic_vector(31 downto 0);
signal fe0_instr_valid : std_logic;

signal de0_rs1_addr : std_logic_vector(4 downto 0);
signal de0_rs2_addr : std_logic_vector(4 downto 0);

signal ex0_rs1_addr : std_logic_vector(4 downto 0);
signal ex0_rs2_addr : std_logic_vector(4 downto 0);

signal rf0_rs1: std_logic_vector(31 downto 0);
signal rf0_rs2: std_logic_vector(31 downto 0);



signal de0_rs1: std_logic_Vector(31 downto 0);
signal de0_rs2: std_logic_Vector(31 downto 0);         
signal de0_imm: std_logic_Vector(31 downto 0);         
signal de0_pc: std_logic_Vector(31 downto 0);          
signal de0_op1_sel: std_logic_Vector(1 downto 0);     
signal de0_op2_sel: std_logic_Vector(1 downto 0);
signal de0_br_en: std_logic;      
signal de0_br_type: std_logic_Vector(2 downto 0);     
signal de0_br_addr_sel: std_logic; 
signal de0_alu_opsel: std_logic_Vector(3 downto 0);   
signal de0_op_sign : std_logic;
signal de0_exe_res_sel: std_logic_vector(1 downto 0); 
signal de0_mem_store_type: std_logic_Vector(1 downto 0);
signal de0_mem_load_type: std_logic_Vector(2 downto 0);
signal de0_wb_en: std_logic;       
signal de0_wb_reg: std_logic_Vector(4 downto 0);      
signal de0_wb_data_sel: std_logic; 
signal de0_mem_en: std_logic;      
signal de0_mem_we: std_logic;      
signal de0_mem_data: std_logic_Vector(31 downto 0);     

signal ex0_exe_res : std_logic_vector(31 downto 0);
signal ex0_br_addr : std_logic_vector(31 downto 0);
signal ex0_br_en : std_logic;
signal ex0_mem_wr_data : std_logic_vector(31 downto 0);
signal ex0_mem_addr    : std_logic_vector(31 downto 0);
signal ex0_mem_we      : std_logic;
signal ex0_mem_en      : std_logic;
signal ex0_wb_data_sel : std_logic;
signal ex0_wb_reg_sel  : std_logic_vector(4 downto 0);
signal ex0_wb_we       : std_logic;
signal ex0_load_type   : std_logic_vector(2 downto 0);
signal ex0_store_type   : std_logic_vector(1 downto 0);

signal ma0_br_addr : std_logic_vector(31 downto 0);
signal ma0_br_en: std_logic;
signal ma0_wb_data: std_logic_vector(31 downto 0);
signal ma0_fb_data: std_logic_vector(31 downto 0);
signal ma0_wb_reg_sel: std_logic_vector(4 downto 0);
signal ma0_wb_we: std_logic;


signal wb0_wb_data: std_logic_vector(31 downto 0);
signal wb0_wb_reg_sel: std_logic_vector(4 downto 0);
signal wb0_wb_we: std_logic;
signal wb0_br_addr: std_logic_vector(31 downto 0);
signal wb0_br_en: std_logic;

--signal wb0_rs1: std_logic_vector(31 downto 0);
--signal wb0_rs2: std_logic_vector(31 downto 0);

signal rs1_fwsel : std_logic_vector(1 downto 0);
signal rs2_fwsel : std_logic_vector(1 downto 0);
signal mem_fwsel : std_logic;
signal de0_rs1_fwsel : std_logic_vector(1 downto 0);
signal de0_rs2_fwsel : std_logic_vector(1 downto 0);
signal de0_mem_fwsel : std_logic;
signal ex0_mem_fwsel : std_logic;
signal de0_cmp_op1sel : std_logic;
signal fetch_stall : std_logic;
signal de0_stall : std_logic;

signal de0_instr_valid   : std_logic;
signal de0_csr_sel   : std_logic;
signal de0_csr_we    : std_logic;
signal de0_csr_rd    : std_logic;
signal de0_csr_wr_data  : std_logic_vector(31 downto 0);
signal de0_csr_wr_addr  : std_logic_vector(11 downto 0);
signal de0_csr_rd_addr  : std_logic_vector(11 downto 0);
signal de0_csr_op    : std_logic_vector(1 downto 0);
signal csr0_csr_data  : std_logic_vector(31 downto 0);

           
signal ex0_pc: std_logic_Vector(31 downto 0); 
signal ex0_instr_valid      : std_logic;

signal ex0_csr_rd      : std_logic;
signal ex0_csr_we      : std_logic;
signal ex0_csr_wr_data : std_logic_vector(31 downto 0);
signal ex0_csr_wr_addr : std_logic_vector(11 downto 0);
signal ex0_csr_rd_addr : std_logic_vector(11 downto 0);
signal ex0_csr_op      : std_logic_vector(1 downto 0);
signal csr0_csr_rd_data: std_logic_vector(31 downto 0);
signal csr0_mtvec: std_logic_vector(31 downto 0);

signal de0_except_ill_instr      : std_logic;
signal exception      : std_logic;
signal exception_id      : std_logic_vector(7 downto 0);
signal exception_arr      : std_logic_vector(7 downto 0);
signal br_flush      : std_logic;
signal tmp      : std_logic;
signal de_safe_zone      : std_logic;
signal ex_safe_zone      : std_logic;
signal interrupt      : std_logic;
signal epc: std_logic_vector(31 downto 0);
signal de0_illegal      : std_logic;
signal ex0_illegal      : std_logic;
signal stall_d1      : std_logic;
signal stall_d2      : std_logic;
begin

--ma0_stall<= '0';
--o_code_mem_en<='1';

fetch_stall <=  ma0_stall ;--or de0_stall;
br_flush<=ex0_br_en or interrupt;
exception <= ex0_illegal or interrupt;

FE0: entity work.fetch  
        port map (
                i_clk           =>i_clk,
                i_rst           =>i_rst,
                                
                i_stall         =>fetch_stall,
                i_branch_addr   =>ex0_br_addr,
                i_evec_addr    =>csr0_mtvec,
                i_branch_en     =>ex0_br_en,  
                i_exception     =>exception,  
                                 
                o_en            =>o_code_mem_en,
                o_addr          =>o_code_mem_addr,
                i_data          =>i_code_mem_data,
                i_valid         =>i_code_mem_valid,
                o_pc            =>fe0_pc,
                o_instr         =>fe0_instr,
                o_instr_valid   =>fe0_instr_valid
        );
DE0: entity work.decode_uc
    port map (
            i_clk           =>i_clk,
            i_rst           =>i_rst,
            i_stall         =>ma0_stall,
            i_flush         =>br_flush,
            
            i_instr_valid   =>fe0_instr_valid,
            i_instr         =>fe0_instr,
            i_pc            =>fe0_pc,

            o_src1_addr     =>de0_rs1_addr,
            o_src2_addr     =>de0_rs2_addr,
            i_src1          =>rf0_rs1,
            i_src2          =>rf0_rs2,
            
        o_uc_addr         => open       ,
        i_data            => x"00000000"          ,
                        
            
            o_rs1           =>de0_rs1,
            o_rs2           =>de0_rs2,
            o_imm           =>de0_imm,
            o_pc            =>de0_pc,
            o_instr_valid   =>de0_instr_valid,
            
            o_rs1_fwsel     =>de0_rs1_fwsel,
            o_rs2_fwsel     =>de0_rs2_fwsel,
            o_mem_fwsel     =>de0_mem_fwsel,
            
            o_cmp_op1sel    =>de0_cmp_op1sel,
            o_op1_sel       =>de0_op1_sel,
            o_op2_sel       =>de0_op2_sel,
                            
            o_br_en         =>de0_br_en,
            o_br_type       =>de0_br_type,
            --o_br_addr_sel   =>de0_br_addr_sel,
            
            o_alu_opsel     =>de0_alu_opsel,
            o_op_sign       =>de0_op_sign,
            o_exe_res_sel   =>de0_exe_res_sel,
            
            o_mem_store_type=>de0_mem_store_type,
            o_mem_load_type =>de0_mem_load_type,
            o_wb_en         =>de0_wb_en,
            o_wb_reg        =>de0_wb_reg,
            o_wb_data_sel   =>de0_wb_data_sel,
            o_mem_en        =>de0_mem_en,
            o_mem_we        =>de0_mem_we,
            --o_mem_addr   :=>
            o_mem_data      =>de0_mem_data,
            o_stall           =>de0_stall,

        o_csr_sel       => de0_csr_sel   ,
        o_csr_we        => de0_csr_we    ,
        o_csr_rd        => de0_csr_rd    ,
        --o_csr_wr_data      => de0_csr_wr_data  ,
        o_csr_wr_addr      => de0_csr_wr_addr,
        o_csr_rd_addr      => de0_csr_rd_addr,
        o_csr_op           => de0_csr_op    ,
        o_except_ill_instr => de0_illegal    
      
            
    );
    stall_d1<='0' when i_rst='1' else ma0_stall when rising_edge(i_clk);
    stall_d2<='0' when i_rst='1' else stall_d1 when rising_edge(i_clk);
    interrupt <= ex_safe_zone and i_irq;
    de_safe_zone<= ex0_br_en and (not (ma0_stall));-- or stall_d1 or stall_d2));
    ex_safe_zone<= ex0_br_en and ex0_instr_valid and (not (ma0_stall));-- or stall_d1 or stall_d2));
    o_ack<= interrupt;
    exception_arr(0)<=ex0_illegal;
    exception_arr(1)<=interrupt;
    exception_arr(2)<='0';
    exception_arr(3)<='0';
    exception_arr(4)<='0';
    exception_arr(5)<='0';
    exception_arr(6)<='0';
    exception_arr(7)<='0';
    exception_id <= exception_arr;
    epc <= ex0_pc when interrupt='1' else
            de0_pc when ex0_illegal='1' else
            x"00000018";
    csr0: entity work.csr_file  
    port map(
            i_clk       =>i_clk,
            i_rst       =>i_rst,
            
            i_rd_addr   =>ex0_csr_rd_addr,
            i_wr_addr   =>ex0_csr_wr_addr,
            i_pc       =>epc,
            i_instr       =>fe0_instr,
            o_mtvec       =>csr0_mtvec,
            i_exception_id=> exception_id,
            i_exception=> exception,
            i_data      =>ex0_csr_wr_data,
            i_we        =>ex0_csr_we,
            i_rd        =>ex0_csr_rd,
                        
            i_op        =>ex0_csr_op,
            o_data      =>csr0_csr_rd_data
    );

----------------------------Forward-------------------------------
rs1_fwsel <= "01" when de0_rs1_addr /= "00000" and de0_rs1_addr= ex0_wb_reg_sel and ex0_wb_we = '1' and tmp='0' else
             "10" when de0_rs1_addr /= "00000" and de0_rs1_addr= ex0_wb_reg_sel and ex0_wb_we = '1' and tmp='1' else
             "10" when de0_rs1_addr /= "00000" and de0_rs1_addr= ma0_wb_reg_sel and ma0_wb_we = '1' else
             "00";

rs2_fwsel <= "01" when de0_rs2_addr /= "00000" and de0_rs2_addr= ex0_wb_reg_sel and ex0_wb_we = '1' and tmp='0' else
             "10" when de0_rs2_addr /= "00000" and de0_rs2_addr= ex0_wb_reg_sel and ex0_wb_we = '1' and tmp='1' else
             "10" when de0_rs2_addr /= "00000" and de0_rs2_addr= ma0_wb_reg_sel and ma0_wb_we = '1' else
             "00";
mem_fwsel  <= '1' when ex0_rs2_addr /= "00000" and ex0_rs2_addr= ma0_wb_reg_sel and ma0_wb_we = '1' else '0';
-------------------------------------------------------------------
tmp <= ma0_stall when rising_edge(i_clk);

EX0: entity work.execute  

    port map( 
            i_clk           => i_clk,
            i_rst           => i_rst,
            i_stall         =>ma0_stall,
            i_flush         =>br_flush,
            i_rs1           =>de0_rs1,
            i_rs2           =>de0_rs2,
            
            i_fw_ee         =>ex0_exe_res,
            i_fw_me         =>ma0_fb_data,
            i_fw_we         =>x"00000000",
            
            i_imm           =>de0_imm,
            i_pc            =>de0_pc,
            o_pc            =>ex0_pc,
            i_instr_valid   =>de0_instr_valid,
            o_instr_valid   =>ex0_instr_valid,
            i_illegal   =>de0_illegal,
            o_illegal   =>ex0_illegal,
                             
            i_rs1_addr     =>de0_rs1_addr,
            i_rs2_addr     =>de0_rs2_addr,
            
            o_rs1_addr     =>ex0_rs1_addr,
            o_rs2_addr     =>ex0_rs2_addr,
            
            i_rs1_fwsel     =>rs1_fwsel,
            i_rs2_fwsel     =>rs2_fwsel,
            i_mem_fwsel     =>de0_mem_fwsel,
            
            i_cmp_op1sel    =>de0_cmp_op1sel,
            i_op1_sel       =>de0_op1_sel,
            i_op2_sel       =>de0_op2_sel,
            i_signed_op     =>de0_op_sign,
                             
            i_alu_sel       =>de0_alu_opsel,
            i_res_sel       =>de0_exe_res_sel,
                             
            i_br_addr_sel   =>'0',
            i_br_type_sel   =>de0_br_type,
            i_br_en         =>de0_br_en,
                             
                             
            i_mem_wr_data   =>de0_mem_data,
            i_mem_we        =>de0_mem_we,
            i_mem_en        =>de0_mem_en,
                             
            i_load_type     =>de0_mem_load_type,
            i_store_type     =>de0_mem_store_type,
                             
            i_wb_data_sel   =>de0_wb_data_sel,
            i_wb_reg_sel    =>de0_wb_reg,
            i_wb_we         =>de0_wb_en,
                          
            o_mem_fwsel     =>ex0_mem_fwsel,   
            o_exe_res       =>ex0_exe_res,
            o_br_addr       =>ex0_br_addr,
            o_br_en         =>ex0_br_en        ,
            o_mem_wr_data   =>ex0_mem_wr_data  ,
            o_mem_addr      =>ex0_mem_addr     ,
            o_mem_we        =>ex0_mem_we       ,
            o_mem_en        =>ex0_mem_en,
            o_wb_data_sel   =>ex0_wb_data_sel  ,
            o_wb_reg_sel    =>ex0_wb_reg_sel   ,
            o_wb_we         =>ex0_wb_we        ,
            o_load_type     =>ex0_load_type    ,
            o_store_type    =>ex0_store_type   ,
            
            i_csr_sel      =>de0_csr_sel     ,
            i_csr_rd       =>de0_csr_rd      ,
            i_csr_we       =>de0_csr_we      ,
            i_csr_wr_addr  =>de0_csr_wr_addr ,
            i_csr_rd_addr  =>de0_csr_rd_addr ,
            i_csr_op       =>de0_csr_op      ,
            o_csr_rd       =>ex0_csr_rd      ,
            o_csr_we       =>ex0_csr_we      ,
            o_csr_wr_data  =>ex0_csr_wr_data ,
            o_csr_wr_addr  =>ex0_csr_wr_addr ,
            o_csr_rd_addr  =>ex0_csr_rd_addr ,
            o_csr_op       =>ex0_csr_op      ,
            i_csr_rd_data  =>csr0_csr_rd_data  
            
         );

MA0: entity work.memory_access 
  Port map ( 
            i_clk               =>i_clk,
            i_rst               =>i_rst,
                        
            i_exe_res           =>ex0_exe_res,
                                
            i_mem_fwsel           =>mem_fwsel,
            i_fw_mm           =>ma0_wb_data,
            
            i_br_addr           =>ex0_br_addr,
            i_flush             =>br_flush,
                                
            i_mem_wr_data       =>ex0_mem_wr_data,
            i_mem_addr          =>ex0_mem_addr,
            
            i_mem_we            =>ex0_mem_we,
            i_mem_en            =>ex0_mem_en,
            i_mem_we_p            =>de0_mem_we,
            i_mem_en_p            =>de0_mem_en,
            
            i_wb_data_sel       =>ex0_wb_data_sel,
            i_wb_reg_sel        =>ex0_wb_reg_sel,
            i_wb_we             =>ex0_wb_we,
                                
            i_load_type         =>ex0_load_type,
            i_store_type        =>ex0_store_type,
                                
            o_data_mem_en       =>o_data_mem_en,
            o_data_mem_we       =>o_data_mem_we,
            o_data_mem_addr     =>o_data_mem_addr,
            o_data_mem_strobe   =>o_data_mem_strobe,
            i_data_mem_data     =>i_data_mem_data,
            i_data_mem_valid    =>i_data_mem_valid,
            o_data_mem_data     =>o_data_mem_data,
            o_stall             =>ma0_stall,                   
            o_br_addr           =>ma0_br_addr,
            o_br_en             =>ma0_br_en,
            o_fb_data           =>ma0_fb_data,
            o_wb_data           =>ma0_wb_data,
            o_wb_reg_sel        =>ma0_wb_reg_sel,
            o_wb_we             =>ma0_wb_we
            
            
  );



--WB0: entity work.write_back 
--  Port map (
--            i_clk       =>i_clk,
--            i_rst       =>i_rst,
            
--            i_stall         =>ma0_stall,
            
--            i_br_addr   =>ma0_br_addr,
--            i_br_en     =>ma0_br_en,
                        
--            i_wb_data   =>ma0_wb_data,
--            i_wb_reg_sel=>ma0_wb_reg_sel,
--            i_wb_we     =>ma0_wb_we,
                        
                        
--            o_wb_data   =>wb0_wb_data,
--            o_wb_reg_sel=>wb0_wb_reg_sel,
--            o_wb_we     =>wb0_wb_we,
--            o_br_addr   =>wb0_br_addr,
--            o_br_en     =>wb0_branch_en
                        
--   );



RF0: entity work.reg_file  
    port map(
            i_clk       =>i_clk,
            i_rst       =>i_rst,
                        
            i_rs1_addr  =>de0_rs1_addr,
            i_rs2_addr  =>de0_rs2_addr,
                        
            i_wb_data   =>ma0_wb_data,
            i_wb_addr   =>ma0_wb_reg_sel,
            i_we        =>ma0_wb_we,
                        
            o_rs1       =>rf0_rs1,
            o_rs2       =>rf0_rs2
    );



end Behavioral;
