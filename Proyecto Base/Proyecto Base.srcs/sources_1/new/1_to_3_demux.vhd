library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity demux_1_to_3 is
    Port ( datain : in STD_LOGIC;
           selector : in STD_LOGIC_VECTOR (1 downto 0);
           out_1 : out STD_LOGIC;
           out_2 : out STD_LOGIC;
           out_3 : out STD_LOGIC);
end demux_1_to_3;

architecture Behavioral of demux_1_to_3 is

begin
process (datain,selector) is

-- Proceso adaptado de proceso visto en https://allaboutfpga.com/vhdl-code-for-1-to-4-demux/
begin
 if (selector(0) ='0' and selector(1) = '0') then
 out_1 <= datain;
 elsif (selector(0) ='1' and selector(1) = '0') then
 out_2 <= datain;
 else
 out_3 <= datain;
 end if;
end process;

end Behavioral;
