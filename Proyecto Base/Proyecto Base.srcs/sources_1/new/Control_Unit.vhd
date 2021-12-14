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
           cu_status_in : in STD_LOGIC_VECTOR (2 downto 0); -- C,Z,N
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
  -- Realmente los opcodes son de 8, no 7, pero sirven igual (por ahora)
  case cu_in(6 downto 0) is
  
  -- MOV -------------------------------------------------------------------
    when "0000000" => -- A,B -------------------------------
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
      
    when "0000001" => -- B,A -------------------------------
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
      
    when "0000010" => -- A,Lit -----------------------------
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
      
    when "0000011" => -- B,Lit -----------------------------
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
      
    when "0000100" => -- A,(Dir) ---------------------------
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
      
    when "0000101" => -- B,(Dir) ---------------------------
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
      
    when "0000110" => -- (Dir),A ---------------------------
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
    when "0000111" => -- (Dir),B ---------------------------
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
    when "0111111" => -- A,(B) ---------------------------
      enableA <= '1';
      enableB <= '0';
      selA <= "00";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
    when "1000000" => -- B,(B) ---------------------------
      enableA <= '0';
      enableB <= '1';
      selA <= "00";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
    when "1000001" => -- (B),A ---------------------------
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
    when "1000010" => -- (B),Lit ---------------------------
      enableA <= '0';
      enableB <= '0';
      selA <= "00";
      selB <= "11";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
     
      
   --------------------------------------------------------------------------
   -- ADD -------------------------------------------------------------------
     when "0001000" => -- A,B -------------------------------
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
      
     when "0001001" => -- B,A -------------------------------
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
      
     when "0001010" => -- A,Lit -----------------------------
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
      
     when "0001011" => -- B,Lit -----------------------------
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
      
     when "0001100" => -- A,(dir) ---------------------------
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
      
     when "0001101" => -- B,(dir) ---------------------------
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
      
     when "0001110" => -- (dir) -----------------------------
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
      
     when "1000011" => -- A,(B) ---------------------------
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "1000100" => -- B,(B) ---------------------------
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   ------------------------------------------------------------------------
   -- SUB -----------------------------------------------------------------
     when "0001111" => -- A,B -------------------------------
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
      
     when "0010000" => -- B,A -------------------------------
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
      
     when "0010001" => -- A,Lit -----------------------------
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
      
     when "0010010" => -- B,Lit -----------------------------
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
      
     when "0010011" => -- A,(dir) ---------------------------
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
      
     when "0010100" => -- B,(dir) ---------------------------
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
      
      
     when "0010101" => -- (dir) -----------------------------
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
      
     when "1000101" => -- A,(B) ---------------------------
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "1000110" => -- B,(B) ---------------------------
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   --------------------------------------------------------------------------
   -- AND -------------------------------------------------------------------
     when "0010110" => -- A,B ---------------------------
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
      
     when "00010111" => -- B,A ---------------------------
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
      
     when "0011000" => -- A,Lit ---------------------------
      enableA <= '1';
      enableB <= '0';
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
      
     when "0011001" => -- B,Lit ---------------------------
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
      
     when "0011010" => -- A,(Dir) ---------------------------
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
      
     when "0011011" => -- B,(Dir) ---------------------------
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
      
     when "0011100" => -- (Dir) ---------------------------
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

     when "1000111" => -- A,(B) ---------------------------
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "010";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "1001000" => -- B,(B) ---------------------------
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "010";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
  -------------------------------------------------------------------------   
  -- OR -------------------------------------------------------------------
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
    when "1001001" => -- A,(B) ---------------------------
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "011";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "1001010" => -- B,(B) ---------------------------
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "011";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';

  --------------------------------------------------------------------------
  -- XOR -------------------------------------------------------------------
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
      
     when "1001011" => -- A,(B) ---------------------------
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "100";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
     when "1001100" => -- B,(B) ---------------------------
      enableA <= '0';
      enableB <= '1';
      selA <= "01";
      selB <= "10";
      selALU <= "100";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   --------------------------------------------------------------------------   
   -- NOT -------------------------------------------------------------------
     when "0101011" => -- A,A -------------------------------
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
      
     when "0101100" => -- B,A -------------------------------
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
      
     when "0101101" => -- (dir),A ---------------------------
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
     when "1001101" => -- (B),A ---------------------------
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "101";
      loadPC <= '0';
      w <= '1';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   -------------------------------------------------------------------------- 
   -- SHL -------------------------------------------------------------------
     when "0101110" => -- A,A -------------------------------
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
      
     when "0101111" => -- B,A -------------------------------
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
      
     when "0110000" => -- (dir),A ---------------------------
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
     when "1001110" => -- (B),A -----------------------------
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "111";
      loadPC <= '0';
      w <= '1';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   --------------------------------------------------------------------------   
   -- SHR -------------------------------------------------------------------
     when "0110001" => -- A,A -------------------------------
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
      
     when "0110010" => -- B,A -------------------------------
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
      
     when "0110011" => -- (dir),A ---------------------------
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
     
     when "1001111" => -- (B),A -----------------------------
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "01";
      selALU <= "110";
      loadPC <= '0';
      w <= '1';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   --------------------------------------------------------------------------   
   -- INC -------------------------------------------------------------------
     when "0110100" => -- A ---------------------------------
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
      
     when "0110101" => -- B ---------------------------------
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
      
     when "0110110" => -- (dir) -----------------------------
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
     when "1010000" => -- (B) -------------------------------
      enableA <= '0';
      enableB <= '0';
      selA <= "11";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
   --------------------------------------------------------------------------   
   -- DEC -------------------------------------------------------------------
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
     
   -------------------------------------------------------------------------- 
   -- CMP -------------------------------------------------------------------
     when "0111000" => -- A,B ---------------------------------
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
      
     when "0111001" => -- A,Lit ---------------------------
      enableA <= '0';
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
                       
     when "0111010" => -- A,(Dir) -------------------------------
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
     when "1010001" => -- A,(B) -------------------------------
      enableA <= '0';
      enableB <= '0';
      selA <= "01";
      selB <= "10";
      selALU <= "001";
      loadPC <= '0';
      w <= '0';
      selAdd <= "01";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
   -- JMP -------------------------------------------------------------------
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
      
   -- JEQ -------------------------------------------------------------------
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
   -- JNE -------------------------------------------------------------------
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
     
   -- JGT -------------------------------------------------------------------
     when "1010010" =>
         if ((cu_status_in(1)='0') and (cu_status_in(0)='0')) then
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
         else 
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
          end if;
   -- JGE -------------------------------------------------------------------
     when "1010011" =>
         if (cu_status_in(0)='0') then
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
         else 
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
          end if;
   -- JLT -------------------------------------------------------------------
     when "1010100" =>
         if (cu_status_in(0)='1') then
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
         else 
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
          end if;
   -- JLE -------------------------------------------------------------------
     when "1010101" =>
         if ((cu_status_in(1)='1') or (cu_status_in(0)='1')) then
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
         else 
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
          end if;
   -- JCR -------------------------------------------------------------------
     when "1010110" =>
         if (cu_status_in(2)='1') then
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
         else 
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
          end if;
   -- NOP -------------------------------------------------------------------
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
      
   --------------------------------------------------------------------------   
   -- PUSH ------------------------------------------------------------------
     when "1010111" => -- A -------------------------------------
      enableA <= '0';  
      enableB <= '0';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "11";
      incSP  <= '0';
      decSP  <= '1';
      selPC  <= '0';
      selDIn <= '0';
     when "1011000" => -- B -------------------------------------
      enableA <= '0';  
      enableB <= '0';
      selA <= "00";
      selB <= "01";
      selALU <= "000";
      loadPC <= '0';
      w <= '1';
      selAdd <= "11";
      incSP  <= '0';
      decSP  <= '1';
      selPC  <= '0';
      selDIn <= '0';
   --------------------------------------------------------------------------   
   -- POP -------------------------------------------------------------------
     when "1011001" => -- A -------------------------------------
      enableA <= '1';  
      enableB <= '0';
      selA <= "00";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "11";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
     when "1011010" => -- B -------------------------------------
      enableA <= '0';  
      enableB <= '1';
      selA <= "00";
      selB <= "10";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "11";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
   --------------------------------------------------------------------------   
   -- CALL ------------------------------------------------------------------
     when "1011011" => -- Ins -------------------------------------
      enableA <= '0';  
      enableB <= '0';
      selA <= "00";
      selB <= "00";
      selALU <= "000";
      loadPC <= '1';
      w <= '1';
      selAdd <= "11";
      incSP  <= '0';
      decSP  <= '1';
      selPC  <= '0';
      selDIn <= '1';
   --------------------------------------------------------------------------   
   -- RET -------------------------------------------------------------------
     when "1011100" => -- Ins -------------------------------------
      enableA <= '0';  
      enableB <= '0';
      selA <= "00";
      selB <= "00";
      selALU <= "000";
      loadPC <= '1';
      w <= '0';
      selAdd <= "11";
      incSP  <= '0';
      decSP  <= '0';
      selPC  <= '1';
      selDIn <= '0';
      
    -- incSP -----------------------------------------------------------------
    when "1111110" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '1';
      decSP  <= '0';
      selPC  <= '0';
      selDIn <= '0';
      
    -- decSP ----------------------------------------------------------------
    
    when "1111111" =>
      enableA <= '1';
      enableB <= '0';
      selA <= "01";
      selB <= "00";
      selALU <= "000";
      loadPC <= '0';
      w <= '0';
      selAdd <= "00";
      incSP  <= '0';
      decSP  <= '1';
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
