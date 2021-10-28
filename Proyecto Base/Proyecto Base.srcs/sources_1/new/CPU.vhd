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

-- Inicio de la declaración de componentes

 -- Definición de Control Unit
 
 component Control_Unit is
    Port ( cu_in : in STD_LOGIC_VECTOR (19 downto 0);
           cu_status_in : in STD_LOGIC_VECTOR (2 downto 0);
           enableA : out STD_LOGIC;
           enableB : out STD_LOGIC;
           selA : out STD_LOGIC_VECTOR (1 downto 0);
           selB : out STD_LOGIC_VECTOR (1 downto 0);
           loadPC : out STD_LOGIC;
           selALU : out STD_LOGIC_VECTOR (2 downto 0);
           w : out STD_LOGIC);
end component;
   
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

-- Definicion de CountPC

component CountPC is
    Port( 
           clock    : in  std_logic;                        -- Señal del clock (reducido).
           clear    : in  std_logic;                        -- Señal de reset.
           load     : in  std_logic;                        -- Señal de carga.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           datain   : in  std_logic_vector (11 downto 0);   -- Señales de entrada de datos.
           dataout  : out std_logic_vector (11 downto 0));  -- Señales de salida de datos.
end component;

-- Definición de Status
component Status is
    Port( 
           clock    : in  std_logic;                        -- Señal del clock (reducido).
           clear    : in  std_logic;                        -- Señal de reset.
           load     : in  std_logic;                        -- Señal de carga.
           up       : in  std_logic;                        -- Señal de subida.
           down     : in  std_logic;                        -- Señal de bajada.
           datain   : in  std_logic_vector (2 downto 0);   -- Señales de entrada de datos.
           dataout  : out std_logic_vector (2 downto 0));  -- Señales de salida de datos.
end component;

-- Definición de ALU

component ALU is
    Port ( a        : in  std_logic_vector (15 downto 0);  -- Primer operando.
           b        : in  std_logic_vector (15 downto 0);  -- Segundo operando.
           sop      : in  std_logic_vector (2 downto 0);   -- Selector de la operación.
           c        : out std_logic;                       -- Señal de 'carry'.
           z        : out std_logic;                       -- Señal de 'zero'.
           n        : out std_logic;                       -- Señal de 'nagative'.
           result   : out std_logic_vector (15 downto 0)); -- Resultado de la operación.
end component;
-- Fin de la declaración de los componentes.

-- Inicio de la declaración de señales.

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
                 
ram_address <= ins_datain;
ram_datain  <= alu_result;
                 
-- Instancia Control Unit

cu_datain <= rom_dataout(19 downto 0);
lit_datain <= rom_dataout(35 downto 20);
ins_datain <= rom_dataout(35 downto 24);

inst_ControlUnit: Control_Unit port map(
   cu_in => cu_datain,
   cu_status_in => cu_status_in,
   enableA => enableA,
   enableB => enableB,
   selA => selA,
   selB => selB,
   loadPC => loadPC,
   selALU => selALU,
   w => ram_write
);

-- Instancias de RegA y RegB.

inst_RegA: Reg port map(
   clock    => clock,                        -- Señal del clock (reducido).
   clear    => clear,                        -- Señal de reset.
   load     => enableA,                        -- Señal de carga.
   up       => '0',                        -- Señal de subida.
   down     => '0',                        -- Señal de bajada.
   datain   => alu_result,   -- Señales de entrada de datos.
   dataout  => a_reg_out
);

inst_RegB: Reg port map(
   clock    => clock,                        -- Señal del clock (reducido).
   clear    => clear,                        -- Señal de reset.
   load     => enableB,                        -- Señal de carga.
   up       => '0',                        -- Señal de subida.
   down     => '0',                       -- Señal de bajada.
   datain   => alu_result,   -- Señales de entrada de datos.
   dataout  => b_reg_out
);

-- Count PC
inst_CountPC: CountPC port map(
   clock    => clock,                        -- Señal del clock (reducido).
   clear    => clear,                        -- Señal de reset.
   load     => loadPC,                        -- Señal de carga.
   up       => '1',                        -- Señal de subida.
   down     => '0',                       -- Señal de bajada.
   datain   => ins_datain,   -- Señales de entrada de datos.
   dataout  => rom_address
);

-- Status

c_z_n(2) <= alu_c;
c_z_n(1) <= alu_z;
c_z_n(0) <= alu_n;
 
inst_Status: Status port map(
   clock    => clock,                        -- Señal del clock (reducido).
   clear    => clear,                        -- Señal de reset.
   load     => '1',                        -- Señal de carga.
   up       => '0',                        -- Señal de subida.
   down     => '0',                       -- Señal de bajada.
   datain   => c_z_n,   -- Señales de entrada de datos.
   dataout  => cu_status_in
);

-- ALU

inst_ALU: ALU port map(
           a        => mux_a_out,  -- Primer operando.
           b        => mux_b_out,  -- Segundo operando.
           sop      => selALU,   -- Selector de la operación.
           c        => alu_c,                       -- Señal de 'carry'.
           z        => alu_z,                       -- Señal de 'zero'.
           n        => alu_n,                       -- Señal de 'nagative'.
           result   => alu_result
);

-- Display

dis(15 downto 8) <= a_reg_out(7 downto 0);
dis(7 downto 0) <= b_reg_out(7 downto 0);


end Behavioral;

