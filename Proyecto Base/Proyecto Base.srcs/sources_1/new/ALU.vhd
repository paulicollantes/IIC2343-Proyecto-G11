library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);  -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);  -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);   -- Selector de la operación.
           c        : out std_logic;                       -- Señal de 'carry'.
           z        : out std_logic;                       -- Señal de 'zero'.
           n        : out std_logic;                       -- Señal de 'nagative'.
           result   : out std_logic_vector (15 downto 0)); -- Resultado de la operación.
end ALU;

architecture Behavioral of ALU is

component Adder16
    Port ( a  : in  std_logic_vector (15 downto 0);
           b  : in  std_logic_vector (15 downto 0);
           ci : in  std_logic;
           s  : out std_logic_vector (15 downto 0);
           co : out std_logic);
    end component;
    
signal adder_b   : std_logic_vector(15 downto 0);
signal adder_s   : std_logic_vector(15 downto 0);
signal adder_ci   : std_logic;
signal adder_co   : std_logic;

signal alu_result   : std_logic_vector(15 downto 0);

begin

-- Sumador/Restador
-- Cuando sumemos nos importara que el carry_in sea 0 y 1 para la resta
adder_ci <= sop(0) and (not sop(1)) and (not sop(2)); -- setea carry_in=1 al asegurarse que sea "001" (resta)

with adder_ci select
    adder_b <= b     when '0',
               not b when '1'; --crea el numero negativo para la resta


                
-- Resultado de la Operación
               
with sop select
    alu_result <= adder_s              when "000", -- Suma
                  adder_s              when "001", -- Resta
                  a and b              when "010", -- And
                  a or b               when "011", -- Or
                  a xor b              when "100", -- Xor
                  not a                when "101", -- Not
                  '0' & a(15 downto 1)  when "110", -- Shift Right
                  a(14 downto 0) & '0'  when "111"; -- Shift Left 
                  
result  <= alu_result;

-- Flags c z n

with sop select
    c <=          adder_co       when "000", -- Suma
                  adder_co       when "001", -- Resta
                  '0'            when "010", -- And
                  '0'            when "011", -- Or
                  '0'            when "100", -- Xor
                  '0'            when "101", -- Not
                  a(0)           when "110", -- Shift Right
                  a(15)          when "111"; -- Shift Left . Ese 7 habría que cambiarlo 
                                             -- cuando pasemos de 8 bits a 16 bits
-- Alu _result es la señal intermedia. Cuando todos sean 0, z debe ser 1
--z <= ((alu_result(0) nor alu_result(1)) and (alu_result(2) nor alu_result(3)))
--         and ((alu_result(0) nor alu_result(1)) and (alu_result(0) nor alu_result(1)))  ;

with alu_result select
      z <= '1' when "0000000000000000",
           '0'  when others;

-- Ya que solo importa cuando hay resta y b > a
n <= adder_ci and not adder_co;

inst_Adder16: Adder16 port map(
        a      =>a,
        b      =>adder_b, --a veces queremos un b invertido, por eso pasamos 
        ci     =>adder_ci,
        s      =>adder_s,
        co     =>adder_co
    );
    
    
-- Debouncer Recibe un clock, una señal y devuelve una señal 
-- sin rebote. Sin múltiples señales por apretar un boton
             
               
    
end Behavioral;

