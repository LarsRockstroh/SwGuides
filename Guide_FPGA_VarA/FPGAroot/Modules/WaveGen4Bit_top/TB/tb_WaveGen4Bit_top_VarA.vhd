-----------------------------------------------------------------------------------
-- License: CC0-1.0 https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt
-- Repository: https://github.com/LarsRockstroh/SwGuides/
-- Filename: tb_WaveGen4Bit_top_VarA.vhd
-- Language: VHDL-2008
-- History:
-- 01.00, 2026-02-28
--   Initial
-----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.env.finish;

entity tb_WaveGen4Bit_top_VarA is
end tb_WaveGen4Bit_top_VarA;

architecture Sim of tb_WaveGen4Bit_top_VarA is
  constant C_ClockPeriod : time := 20 ns;  -- 50 MHz

  -- Signals connected to device under test (DUT)
  signal s_Clk         : std_logic;
  signal s_Reset       : std_logic;
  signal s_Limit       : unsigned(3 downto 0);
  signal s_Limit_Valid : std_logic;
  signal s_Limit_Ready : std_logic;
  signal s_Wave        : unsigned(3 downto 0);

begin
  ClockGen_P : process
  begin
    s_Clk <= '0';
    wait for C_ClockPeriod / 2;
    s_Clk <= '1';
    wait for C_ClockPeriod / 2;
  end process ClockGen_P;

  SimGen_P : process
  begin
    s_Reset       <= '0';
    s_Limit       <= (others => '0');
    s_Limit_Valid <= '0';
    for i in 1 to 10 loop
      wait until rising_edge(s_Clk);
    end loop;
    s_Reset <= '1';
    for i in 1 to 2 loop
      wait until rising_edge(s_Clk);
    end loop;
    s_Limit_Valid <= '1';
    s_Limit       <= to_unsigned(0,4);
    wait until rising_edge(s_Clk);
    s_Limit_Valid <= '0';    
    for i in 1 to 4 loop
      wait until rising_edge(s_Clk);
    end loop;
    s_Limit_Valid <= '1';
    s_Limit       <= to_unsigned(3,4);
    wait until rising_edge(s_Clk);
    s_Limit_Valid <= '0';
    for i in 1 to 20 loop
      wait until rising_edge(s_Clk);
    end loop;
    report "Calling 'finish'";
    finish;

  end process SimGen_P;


  DUT : entity work.WaveGen4Bit_top_VarA    -- Instantiation of other VHDL module
    port map(
      i_Clk_48MHz    => s_Clk,  
      i_nPOR_FPGA    => s_Reset,  
      i_Limit        => s_Limit,      
      i_Limit_Valid  => s_Limit_Valid,
      o_Limit_Ready  => s_Limit_Ready,
      o_Wave         => s_Wave       
      );

end Sim;
