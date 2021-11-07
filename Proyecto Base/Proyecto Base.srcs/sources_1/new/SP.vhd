----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 07.11.2021 11:44:32
-- Design Name: 
-- Module Name: SP - Behavioral
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

entity SP is
    Port ( incSP : in STD_LOGIC;
           decSP : in STD_LOGIC;
           clear : in STD_LOGIC;
           SP_out : out STD_LOGIC_VECTOR (11 downto 0));
end SP;

architecture Behavioral of SP is

 -- Definición de Reg
 component Reg is
    Port( 
           clock    : in  std_logic;                        -- Señal del clock (reducido).
           clear    : in  std_logic;                        -- Señal de reset.
           load     : in  std_logic;                        -- Señal de carga.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           datain   : in  std_logic_vector (15 downto 0);   -- Señales de entrada de datos.
           dataout  : out std_logic_vector (15 downto 0));  -- Señales de salida de datos.
end component;

signal reg_out : std_logic_vector(15 downto 0);

begin


inst_Reg: Reg port map(
   clock    => '0',                        -- Señal del clock (reducido).
   clear    => clear,                        -- Señal de reset.
   load     => '1',                        -- Señal de carga.
   up       => incSP,                        -- Señal de subida.
   down     => decSP,                        -- Señal de bajada.
   datain   => "0000000000000000",   -- Señales de entrada de datos.
   dataout  => reg_out
);

SP_out <= reg_out(11 downto 0);


end Behavioral;
