----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.10.2021 19:35:40
-- Design Name: 
-- Module Name: Control_Unit - Behavioral
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

entity Control_Unit is
    Port ( cu_in : in STD_LOGIC_VECTOR (19 downto 0);
           cu_status_in : in STD_LOGIC_VECTOR (2 downto 0);
           enableA : out STD_LOGIC;
           enableB : out STD_LOGIC;
           selA : out STD_LOGIC_VECTOR (1 downto 0);
           selB : out STD_LOGIC_VECTOR (1 downto 0);
           loadPC : out STD_LOGIC;
           selALU : out STD_LOGIC_VECTOR (2 downto 0);
           w : out STD_LOGIC;
           selAdd : out STD_LOGIC_VECTOR(1 downto 0);
           incSP  : out STD_LOGIC;
           decSP  : out STD_LOGIC;
           selPC  : out STD_LOGIC;
           selDIn : out STD_LOGIC);
end Control_Unit;

architecture Behavioral of Control_Unit is

begin
my_process_name : process(cu_in)
begin
  case cu_in(6 downto 0) is
  
  -- MOV
  
    when "0000000" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "00";
      selB <= "01";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    when "0000001" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    when "0000010" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "00";
      selB <= "11";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    when "0000011" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "00";
      selB <= "11";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    when "0000100" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "00";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    when "0000101" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "00";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    when "0000110" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0000111" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "00";
      selB <= "01";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
      
     -- ADD
     
     when "0001000" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0001001" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0001010" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "11";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0001011" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "11";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0001100" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0001101" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
      
     when "0001110" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
      
     -- SUB
     
     when "0001111" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0010000" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0010001" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "11";
      selALU <= "001";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0010010" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "11";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0010011" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0010100" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
      
     when "0010101" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "001";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
      
     -- AND
     when "0010110" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "010";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "00010111" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "010";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0011000" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "11";
      selALU <= "010";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0011001" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "11";
      selALU <= "010";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0011010" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "010";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0011011" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "010";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0011100" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "010";
      loadPC <= '0';
      w <= '1';  
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   -- OR
    when "0011101" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "011";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0011110" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "011";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0011111" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "11";
      selALU <= "011";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0100000" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "11";
      selALU <= "011";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0100001" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "011";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0100010" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "011";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
      
     when "0100011" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "011";
      loadPC <= '0';
      w <= '1'; 
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';

--  XOR

    when "0100100" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "100";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0100101" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "100";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0100110" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "11";
      selALU <= "100";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0100111" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "11";
      selALU <= "100";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0101000" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "100";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0101001" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "100";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0101010" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "100";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    -- NOT
     when "0101011" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "101";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0101100" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "101";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0101101" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "101";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    -- SHL
     when "0101110" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "111";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0101111" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "111";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0110000" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "111";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     -- SHR
     when "0110001" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "110";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0110010" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "01";
      selALU <= "110";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0110011" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "110";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    -- INC
     when "0110100" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "11";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0110101" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "11";
      selB <= "01";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0110110" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "11";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    -- DEC
     when "0110111" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "11";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     -- CMP
     when "0111000" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0111001" =>
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "11";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "0111010" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
      
    -- JMP
    
     when "0111011" =>
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "001";
      loadPC <= '1';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    -- JEQ
    
     when "0111100" =>
      case cu_status_in(1) is
       when '1' =>
          enableA <= '0';
          enableB <= '0';
          selA <= "01";
          selB <= "10";
          selALU <= "001";
          loadPC <= '1';
          w <= '0';
          selAdd <= "00";
          incSP  <= '0';
          decSP  <= '0';
          selPC  <= '0';
          selDIn <= '0';
          
       when others =>
          enableA <= '1';
          enableB <= '0';
          selA <= "01";
          selB <= "00";
          selALU <= "000";
          loadPC <= '0';
          w <= '0';
          selAdd <= "00";
          incSP  <= '0';
          decSP  <= '0';
          selPC  <= '0';
          selDIn <= '0';
      end case;
      
    -- JNE
     when "0111101" =>
      case cu_status_in(1) is
          when '0' =>
              enableA <= '0';
              enableB <= '0';
              selA <= "01";
              selB <= "10";
              selALU <= "001";
              loadPC <= '1';
              w <= '0';
              selAdd <= "00";
              incSP  <= '0';
              decSP  <= '0';
              selPC  <= '0';
              selDIn <= '0';
              
         when others =>
              enableA <= '1';
              enableB <= '0';
              selA <= "01";
              selB <= "00";
              selALU <= "000";
              loadPC <= '0';
              w <= '0';
              selAdd <= "00";
              incSP  <= '0';
              decSP  <= '0';
              selPC  <= '0';
              selDIn <= '0';
     end case;
    -- NOP 
     when "0111110" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
     
     when others => -- Nunca debería dar esta opción. Hace lo mismo que NOP
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
  end case;
end process;


end Behavioral;
