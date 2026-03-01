-----------------------------------------------------------------------------------
-- License: CC0-1.0 https://creativecommons.org/publicdomain/zero/1.0/legalcode.txt
-- Repository: https://github.com/LarsRockstroh/SwGuides/
-- Filename: WaveGen4Bit_top_VarA.vhd
-- Language: VHDL-2008
-- Description: Top-level module WaveGen4Bit
-- History:
-- 01.00, 2026-02-28
--   Initial
-----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;  -- data types std_logic, std_logic_vector; operations
use ieee.numeric_std.all;     -- data types unsigned, signed; operations




entity WaveGen4Bit_top_VarA is
  port (
    i_Clk_48MHz   : in  std_logic;          
    i_nPOR_FPGA   : in  std_logic;
    i_Limit       : in  unsigned(3 downto 0);
    i_Limit_Valid : in  std_logic;
    o_Limit_Ready : out std_logic;
    o_Wave        : out unsigned(3 downto 0)
    );
end WaveGen4Bit_top_VarA;

architecture Behavioral of WaveGen4Bit_top_VarA is
 -- Solution without FSM; more classical approch includes using a FSM
 signal s_Reset       : std_logic;
 signal s_WaveIntern  : unsigned(3 downto 0);
 signal s_LimitIntern : unsigned(3 downto 0);
 
begin

  Logic_P : process(i_Clk_48MHz)
  begin
    if Rising_Edge(i_Clk_48MHz) then
      if (o_Limit_Ready = '0') then
        s_WaveIntern <= s_WaveIntern + 1;
      end if;
    
      if (s_LimitIntern = s_WaveIntern) then
        s_WaveIntern  <= s_WaveIntern;
        o_Limit_Ready <= '1';
      end if;
      
      if (o_Limit_Ready = '1' and i_Limit_Valid = '1') then
        s_LimitIntern <= i_Limit;
        s_WaveIntern  <= s_WaveIntern + 1;
        o_Limit_Ready <= '0';
      end if;
      
      if (s_Reset = '1') then
       s_LimitIntern <= (others => '0');
       s_WaveIntern  <= (others => '0');
       o_Limit_Ready <= '0';        
      end if;
    end if;
  end process Logic_P;
  
  o_Wave <= s_WaveIntern;

  Reset_P : process(i_Clk_48MHz)
  begin
    if Rising_Edge(i_Clk_48MHz) then
      s_Reset <= not(i_nPOR_FPGA);
    end if;
  end process Reset_P;

end Behavioral;
