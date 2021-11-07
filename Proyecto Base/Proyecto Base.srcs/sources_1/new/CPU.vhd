library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity CPU is
    Port (
           clock : in STD_LOGIC;
           clear : in STD_LOGIC;
           ram_address : out STD_LOGIC_VECTOR (11 downto 0);
           ram_datain : out STD_LOGIC_VECTOR (15 downto 0);
           ram_dataout : in STD_LOGIC_VECTOR (15 downto 0);
           ram_write : out STD_LOGIC;
           rom_address : out STD_LOGIC_VECTOR (11 downto 0);
           rom_dataout : in STD_LOGIC_VECTOR (35 downto 0);
           dis : out STD_LOGIC_VECTOR (15 downto 0));
end CPU;

architecture Behavioral of CPU is

-- Inicio de la declaraci�n de componentes

 -- Definici�n de Control Unit
 
 component Control_Unit is
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
end component;
   
 -- Definici�n de Reg
 component Reg is
    Port( 
           clock    : in  std_logic;                        -- Se�al del clock (reducido).
           clear    : in  std_logic;                        -- Se�al de reset.
           load     : in  std_logic;                        -- Se�al de carga.
           up       : in  std_logic;                        -- Se�al de subida.
           down     : in  std_logic;                        -- Se�al de bajada.
           datain   : in  std_logic_vector (15 downto 0);   -- Se�ales de entrada de datos.
           dataout  : out std_logic_vector (15 downto 0));  -- Se�ales de salida de datos.
end component;

-- Definicion de CountPC

component CountPC is
    Port( 
           clock    : in  std_logic;                        -- Se�al del clock (reducido).
           clear    : in  std_logic;                        -- Se�al de reset.
           load     : in  std_logic;                        -- Se�al de carga.
           up       : in  std_logic;                        -- Se�al de subida.
           down     : in  std_logic;                        -- Se�al de bajada.
           datain   : in  std_logic_vector (11 downto 0);   -- Se�ales de entrada de datos.
           dataout  : out std_logic_vector (11 downto 0));  -- Se�ales de salida de datos.
end component;

-- Definici�n de Status
component Status is
    Port( 
           clock    : in  std_logic;                        -- Se�al del clock (reducido).
           clear    : in  std_logic;                        -- Se�al de reset.
           load     : in  std_logic;                        -- Se�al de carga.
           up       : in  std_logic;                        -- Se�al de subida.
           down     : in  std_logic;                        -- Se�al de bajada.
           datain   : in  std_logic_vector (2 downto 0);   -- Se�ales de entrada de datos.
           dataout  : out std_logic_vector (2 downto 0));  -- Se�ales de salida de datos.
end component;

-- Definici�n de ALU

component ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);  -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);  -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);   -- Selector de la operaci�n.
           c        : out std_logic;                       -- Se�al de 'carry'.
           z        : out std_logic;                       -- Se�al de 'zero'.
           n        : out std_logic;                       -- Se�al de 'nagative'.
           result   : out std_logic_vector (15 downto 0)); -- Resultado de la operaci�n.
end component;

-- Definici�n de Adder

component Adder16 is
    Port ( a  : in  std_logic_vector (15 downto 0);
           b  : in  std_logic_vector (15 downto 0);
           ci : in  std_logic;
           s  : out std_logic_vector (15 downto 0);
           co : out std_logic);
end component;

-- Definici�n de SP

component SP is
    Port ( incSP : in STD_LOGIC;
           decSP : in STD_LOGIC;
           clear : in STD_LOGIC;
           SP_out : out STD_LOGIC_VECTOR (11 downto 0));
end component;


-- Fin de la declaraci�n de los componentes.

-- Inicio de la declaraci�n de se�ales.

signal alu_result       : std_logic_vector(15 downto 0);
signal a_reg_out        : std_logic_vector(15 downto 0);

signal b_reg_out        : std_logic_vector(15 downto 0);

signal alu_z            : std_logic;
signal alu_n            : std_logic;
signal alu_c            : std_logic;

signal mux_a_out        : std_logic_vector(15 downto 0);
signal mux_b_out        : std_logic_vector(15 downto 0);

signal selA             : std_logic_vector(1 downto 0);
signal selB             : std_logic_vector(1 downto 0);
signal selALU           : std_logic_vector(2 downto 0);
signal enableA          : std_logic;
signal enableB          : std_logic;

signal loadPC           : std_logic;

signal c_z_n            : std_Logic_vector(2 downto 0);

signal countpc_dataout  : std_logic_vector(11 downto 0);


signal cu_datain        : std_logic_vector(19 downto 0);
signal cu_status_in     : std_logic_vector(2 downto 0);

signal lit_datain       : std_logic_vector(15 downto 0);
signal ins_datain       : std_logic_vector(11 downto 0);

signal countPC_out      : std_logic_vector(11 downto 0);
signal countPC_in    : std_logic_vector(11 downto 0);

signal adder_out        : std_logic_vector(15 downto 0);
signal adder_co         : std_logic;


signal selAdd        : std_logic_vector(1 downto 0);
signal incSP         : std_logic;
signal decSP         : std_logic;
signal selPC         : std_logic;
signal selDIn        : std_logic;

signal SP_out        : std_logic_vector(11 downto 0);

signal adder_modifier : std_logic_vector(15 downto 0);



begin

-- MuxA

with selA select
    mux_a_out <= "0000000000000000" when "00",
                 "0000000000000001" when "11",
                 a_reg_out when "01",
                 "0000000000000000" when others;
                 
-- MuxB

with selB select
    mux_b_out <= "0000000000000000" when "00",
                 b_reg_out when "01",
                 ram_dataout when "10",
                 lit_datain when "11";
                 
                 
-- Mux PC

with selPC select
    countPC_in <= ins_datain when '0',
                   ram_dataout(11 downto 0) when '1';

-- Mux datain

with selDIn select
    ram_datain <= alu_result when '0',
                   adder_out when '1';

-- Mux S
with selAdd select
    ram_address <= ins_datain when "00",
                 b_reg_out(11 downto 0) when "01",
                 SP_out when others;
                 
-- Instancia Control Unit

cu_datain <= rom_dataout(19 downto 0);
lit_datain <= rom_dataout(35 downto 20);
ins_datain <= rom_dataout(31 downto 20);

inst_ControlUnit: Control_Unit port map(
   cu_in => cu_datain,
   cu_status_in => cu_status_in,
   enableA => enableA,
   enableB => enableB,
   selA => selA,
   selB => selB,
   loadPC => loadPC,
   selALU => selALU,
   w => ram_write,
   selAdd => selAdd,
   incSP  => incSP,
   decSP  => decSP,
   selPC  => selPC,
   selDIn => selDIn
);

-- Instancias de RegA y RegB.

inst_RegA: Reg port map(
   clock    => clock,                        -- Se�al del clock (reducido).
   clear    => clear,                        -- Se�al de reset.
   load     => enableA,                        -- Se�al de carga.
   up       => '0',                        -- Se�al de subida.
   down     => '0',                        -- Se�al de bajada.
   datain   => alu_result,   -- Se�ales de entrada de datos.
   dataout  => a_reg_out
);

inst_RegB: Reg port map(
   clock    => clock,                        -- Se�al del clock (reducido).
   clear    => clear,                        -- Se�al de reset.
   load     => enableB,                        -- Se�al de carga.
   up       => '0',                        -- Se�al de subida.
   down     => '0',                       -- Se�al de bajada.
   datain   => alu_result,   -- Se�ales de entrada de datos.
   dataout  => b_reg_out
);

-- Adder

adder_modifier <= "0000000000000000";
adder_modifier(11 downto 0) <= countPC_out; 

inst_Adder: Adder16 port map(
   a    => "0000111111111111",                        -- Se�al del clock (reducido).
   b    => adder_modifier,                        -- Se�al de reset.
   ci   => '0',                        -- Se�al de carga.
   s    => adder_out,                        -- Se�al de subida.
   co   => adder_co                     -- Se�al de bajada.
   );
-- Count PC
inst_CountPC: CountPC port map(
   clock    => clock,                        -- Se�al del clock (reducido).
   clear    => clear,                        -- Se�al de reset.
   load     => loadPC,                        -- Se�al de carga.
   up       => '1',                        -- Se�al de subida.
   down     => '0',                       -- Se�al de bajada.
   datain   => countPC_in,   -- Se�ales de entrada de datos.
   dataout  => countPC_out
);

-- SP

inst_SP: SP port map(
   incSP    => incSP,                        -- Se�al del clock (reducido).
   decSP    => decSP,                        -- Se�al de reset.
   clear   => clear,                        -- Se�al de carga.
   SP_out    => SP_out                        -- Se�al de subida.                   -- Se�al de bajada.
   );
-- Status

c_z_n(2) <= alu_c;
c_z_n(1) <= alu_z;
c_z_n(0) <= alu_n;
 
inst_Status: Status port map(
   clock    => clock,                        -- Se�al del clock (reducido).
   clear    => clear,                        -- Se�al de reset.
   load     => '1',                        -- Se�al de carga.
   up       => '0',                        -- Se�al de subida.
   down     => '0',                       -- Se�al de bajada.
   datain   => c_z_n,   -- Se�ales de entrada de datos.
   dataout  => cu_status_in
);

-- ALU

inst_ALU: ALU port map(
           a        => mux_a_out,  -- Primer operando.
           b        => mux_b_out,  -- Segundo operando.
           sop      => selALU,   -- Selector de la operaci�n.
           c        => alu_c,                       -- Se�al de 'carry'.
           z        => alu_z,                       -- Se�al de 'zero'.
           n        => alu_n,                       -- Se�al de 'nagative'.
           result   => alu_result
);

-- Display

dis(15 downto 8) <= a_reg_out(7 downto 0);
dis(7 downto 0) <= b_reg_out(7 downto 0);


end Behavioral;

