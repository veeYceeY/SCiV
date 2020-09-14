

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity uart_tx is
    port(
            i_clk       : in std_logic;
            i_rstn       : in std_logic;
            i_baud_clk  : in std_logic;
            
            i_en        : in std_logic;
            
            i_parity    : in std_logic;
            
            i_txdata    : in std_logic_vector(7 downto 0);
            i_txen      : in std_logic;
            o_done      : out std_logic;

            o_tx        : out std_logic
    );
end uart_tx;

architecture arch_uart_tx of uart_tx is
    signal count : std_logic_vector(3 downto 0);
    signal tx_buff : std_logic_vector(10 downto 0);
    signal sh_en : std_logic;
    signal txdata_cdc0 : std_logic_vector(7 downto 0);
    signal txdata_cdc1 : std_logic_vector(7 downto 0);
    signal txen_cdc0 : std_logic;
    signal txen_cdc1 : std_logic;
    signal txen_cdc2 : std_logic;
    signal done : std_logic;
    signal txen_lth : std_logic;
    signal parity : std_logic;
begin


parity <= '0';

process(i_baud_clk,i_rstn)
begin
    if i_rstn = '0' then
        txdata_cdc0 <= (others => '0');
        txdata_cdc1 <= (others => '0');
        txen_cdc0 <= '0';
        txen_cdc1 <= '0';
        txen_cdc2 <= '0';
    elsif rising_edge(i_baud_clk) then
        if i_en = '1' then
            txdata_cdc0 <= i_txdata;
            txdata_cdc1 <= txdata_cdc0;
            txen_cdc0 <= i_txen;
            txen_cdc1 <= txen_cdc0;
            txen_cdc2 <= txen_cdc1;
        end if;
    end if;
end process;


txen_lth <= '1' when txen_cdc1 = '1' and txen_cdc2 = '0' else '0';

process(i_baud_clk,i_rstn)
begin
    if i_rstn = '0' then
        tx_buff<= (others=>'1');
    elsif rising_edge(i_baud_clk) then
        if i_en = '1' then
            if txen_lth = '1' then
                tx_buff<='1'  & parity & txdata_cdc1 & '0';
            elsif sh_en = '1' then
                tx_buff <= '1' & tx_buff(10 downto 1);
            end if;
        end if;
    end if;
end process;

sh_en <= '1' when count > x"0" else '0';
done <= '1' when count = 0 else '0';

process(i_baud_clk,i_rstn)
begin
    if i_rstn = '0' then
        count <= (others=>'0');
    elsif rising_edge(i_baud_clk) then
        if i_en = '1' then
            if txen_lth = '1' then
                count <= x"B";
            else  
                if count > 0 then
                    count<= count-'1';
                end if;
            end if;
        end if;
    end if;
end process;

o_tx <= tx_buff(0);
o_done <= done;

end arch_uart_tx;



    