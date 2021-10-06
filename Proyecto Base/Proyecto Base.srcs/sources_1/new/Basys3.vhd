library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Basys3 is
    Port (
        sw          : in   std_logic_vector (15 downto 0); -- No Tocar - Señales de entrada de los interruptores -- Arriba   = '1'   -- Los 16 swiches.
        btn         : in   std_logic_vector (4 downto 0);  -- No Tocar - Señales de entrada de los botones       -- Apretado = '1'   -- 0 central, 1 arriba, 2 izquierda, 3 derecha y 4 abajo.
        led         : out  std_logic_vector (15 downto 0); -- No Tocar - Señales de salida  a  los leds          -- Prendido = '1'   -- Los 16 leds.
        clk         : in   std_logic;                      -- No Tocar - Señal de entrada del clock              -- 100Mhz.
        seg         : out  std_logic_vector (7 downto 0);  -- No Tocar - Salida de las señales de segmentos.
        an          : out  std_logic_vector (3 downto 0);  -- No Tocar - Salida del selector de diplay.
        tx          : out  std_logic;                      -- No Tocar - Señal de salida para UART Tx.
        rx          : in   std_logic                       -- No Tocar - Señal de entrada para UART Rx.
          );
end Basys3;

architecture Behavioral of Basys3 is

-- Inicio de la declaración de los componentes.

component Clock_Divider -- No Tocar
    Port (
        clk         : in    std_logic;
        speed       : in    std_logic_vector (1 downto 0);
        clock       : out   std_logic
          );
    end component;
    
component Display_Controller -- No Tocar
    Port (  
        dis_a       : in    std_logic_vector (3 downto 0);
        dis_b       : in    std_logic_vector (3 downto 0);
        dis_c       : in    std_logic_vector (3 downto 0);
        dis_d       : in    std_logic_vector (3 downto 0);
        clk         : in    std_logic;
        seg         : out   std_logic_vector (7 downto 0);
        an          : out   std_logic_vector (3 downto 0)
          );
    end component;
    
component Debouncer -- No Tocar
    Port (
        clk         : in    std_logic;
        signal_in      : in    std_logic;
        signal_out     : out   std_logic
          );
    end component;
            

component ROM -- No Tocar
    Port (
        clk         : in    std_logic;
        write       : in    std_logic;
        disable     : in    std_logic;
        address     : in    std_logic_vector (11 downto 0);
        dataout     : out   std_logic_vector (35 downto 0);
        datain      : in    std_logic_vector(35 downto 0)
          );
    end component;

component RAM -- No Tocar
    Port (  
        clock       : in    std_logic;
        write       : in    std_logic;
        address     : in    std_logic_vector (11 downto 0);
        datain      : in    std_logic_vector (15 downto 0);
        dataout     : out   std_logic_vector (15 downto 0)
          );
    end component;
    
component Programmer -- No Tocar
    Port (
        rx          : in    std_logic;
        tx          : out   std_logic;
        clk         : in    std_logic;
        clock       : in    std_logic;
        bussy       : out   std_logic;
        ready       : out   std_logic;
        address     : out   std_logic_vector(11 downto 0);
        dataout     : out   std_logic_vector(35 downto 0)
        );
    end component;
    
component CPU is
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
    end component;
    
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

signal clock            : std_logic;                     -- Señal del clock reducido.
            
signal dis_a            : std_logic_vector(3 downto 0);  -- Señales de salida al display A.    
signal dis_b            : std_logic_vector(3 downto 0);  -- Señales de salida al display B.     
signal dis_c            : std_logic_vector(3 downto 0);  -- Señales de salida al display C.    
signal dis_d            : std_logic_vector(3 downto 0);  -- Señales de salida al display D.

signal dis              : std_logic_vector(15 downto 0); -- Señales de salida totalidad de los displays.

signal d_btn            : std_logic_vector(4 downto 0);  -- Señales de botones con anti-rebote.

signal write_rom        : std_logic;                     -- Señal de escritura de la ROM.
signal pro_address      : std_logic_vector(11 downto 0); -- Señales del direccionamiento de programación de la ROM.
signal rom_datain       : std_logic_vector(35 downto 0); -- Señales de la palabra a programar en la ROM.

signal clear            : std_logic;                     -- Señal de limpieza de registros durante la programación.

signal cpu_rom_address  : std_logic_vector(11 downto 0); -- Señales del direccionamiento de lectura de la ROM.
signal rom_address      : std_logic_vector(11 downto 0); -- Señales del direccionamiento de la ROM.
signal rom_dataout      : std_logic_vector(35 downto 0); -- Señales de la palabra de salida de la ROM.

signal write_ram        : std_logic;                     -- Señal de escritura de la RAM.
signal ram_address      : std_logic_vector(11 downto 0); -- Señales del direccionamiento de la RAM.
signal ram_datain       : std_logic_vector(15 downto 0); -- Señales de la palabra de entrada de la RAM.
signal ram_dataout      : std_logic_vector(15 downto 0); -- Señales de la palabra de salida de la RAM.

-- señales propias 

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
signal w                : std_logic;
signal enableA          : std_logic;
signal enableB          : std_logic;

signal loadPC           : std_logic;

signal c_z_n            : std_Logic_vector(2 downto 0);

signal countpc_dataout  : std_logic_vector(11 downto 0);

signal pc_rom_address   : std_logic_vector(11 downto 0);

signal cpu_rom_dataout  : std_logic_vector(35 downto 0);

signal cu_datain        : std_logic_vector(19 downto 0);
signal cu_status_in     : std_logic_vector(2 downto 0);

signal lit_datain       : std_logic_vector(15 downto 0);
signal ins_datain       : std_logic_vector(11 downto 0);

signal cpu_ram_dataout  : std_logic_vector(15 downto 0);

signal ram_write        : std_logic;


-- Fin de la declaración de los señales.

begin

dis_a  <= dis(15 downto 12);
dis_b  <= dis(11 downto 8);
dis_c  <= dis(7 downto 4);
dis_d  <= dis(3 downto 0);
                    
-- Muxer del address de la ROM.          
with clear select
    rom_address <= cpu_rom_address when '0',
                   pro_address when '1';
                   
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
                 
-- Inicio de declaración de instancias.

-- Instancia de la CPU.        
-- inst_CPU: CPU port map(
--     clock       => clock,
--     clear       => clear,
--     ram_address => ins_datain,
--     ram_datain  => alu_result,
--     ram_dataout => ram_dataout,
--     ram_write   => write_ram,
--     rom_address => cpu_rom_address,
--     rom_dataout => rom_dataout,
--     dis         => dis
--     );

ram_address <= ins_datain;
ram_datain  <= alu_result;
-- ram_dataout <= ram_dataout;           -- Innecesario
ram_write   <= write_ram;
-- rom_address <= cpu_rom_address;       -- ERROR - Se salta el muxer
rom_dataout <= rom_dataout;
--dis         <= dis;                    --CON ESTO DA MENOS ERRORES
        
cpu_ram_dataout <= ram_dataout;
cpu_rom_dataout <= rom_dataout;


--dis(15 downto 8) <= a_reg_out(7 downto 0);
dis(15 downto 8) <= mux_a_out(7 downto 0);
--dis(7 downto 1) <= b_reg_out(6 downto 0);
--dis(7 downto 0) <= mux_b_out(7 downto 0);
--dis(15 downto 8) <= rom_dataout(27 downto 20);
dis(7 downto 0) <= rom_dataout(7 downto 0);
--dis(0) <= clock;

    
-- Instancia Control Unit

cu_datain <= cpu_rom_dataout(19 downto 0);
lit_datain <= cpu_rom_dataout(35 downto 20);
ins_datain <= cpu_rom_dataout(35 downto 24);

inst_ControlUnit: Control_Unit port map(
   cu_in => cu_datain,
   cu_status_in => cu_status_in,
   enableA => enableA,
   enableB => enableB,
   selA => selA,
   selB => selB,
   loadPC => loadPC,
   selALU => selALU,
   w => w
);

write_ram <= w;


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
   dataout  => pc_rom_address
);

cpu_rom_address <= pc_rom_address;

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
-- Instancia de la memoria ROM.
inst_ROM: ROM port map(
    clk         => clk,
    disable     => clear,         -- No Tocar - Señal Entrada
    write       => write_rom,     -- No Tocar - Señal Entrada
    address     => rom_address,   -- Entrada
    dataout     => rom_dataout,   -- Salida
    datain      => rom_datain     -- Entrada
    );

-- Instancia de la memoria RAM.
inst_RAM: RAM port map(
    clock       => clock,
    write       => write_ram,
    address     => ram_address,
    datain      => ram_datain,
    dataout     => ram_dataout
    );
    
 -- Intancia del divisor de la señal del clock.
inst_Clock_Divider: Clock_Divider port map(
    speed       => "00",                    -- Selector de velocidad: "00" full, "01" fast, "10" normal y "11" slow. 
    clk         => clk,                     -- No Tocar - Entrada de la señal del clock completo (100Mhz).
    clock       => clock                    -- No Tocar - Salida de la señal del clock reducido: 25Mhz, 8hz, 2hz y 0.5hz.
    );
    
 -- No Tocar - Intancia del controlador de los displays de 8 segmentos.    
inst_Display_Controller: Display_Controller port map(
    dis_a       => dis_a,                   -- No Tocar - Entrada de señales para el display A.
    dis_b       => dis_b,                   -- No Tocar - Entrada de señales para el display B.
    dis_c       => dis_c,                   -- No Tocar - Entrada de señales para el display C.
    dis_d       => dis_d,                   -- No Tocar - Entrada de señales para el display D.
    clk         => clk,                     -- No Tocar - Entrada del clock completo (100Mhz).
    seg         => seg,                     -- No Tocar - Salida de las señales de segmentos.
    an          => an                       -- No Tocar - Salida del selector de diplay.
	);
    
-- No Tocar - Intancias de los Debouncers.    
inst_Debouncer0: Debouncer port map( clk => clk, signal_in => btn(0), signal_out => d_btn(0) );
inst_Debouncer1: Debouncer port map( clk => clk, signal_in => btn(1), signal_out => d_btn(1) );
inst_Debouncer2: Debouncer port map( clk => clk, signal_in => btn(2), signal_out => d_btn(2) );
inst_Debouncer3: Debouncer port map( clk => clk, signal_in => btn(3), signal_out => d_btn(3) );
inst_Debouncer4: Debouncer port map( clk => clk, signal_in => btn(4), signal_out => d_btn(4) );

-- No Tocar - Intancia del ROM Programmer.           
inst_Programmer: Programmer port map(
    rx          => rx,                      -- No Tocar - Salida de la señal de transmición.
    tx          => tx,                      -- No Tocar - Entrada de la señal de recepción.
    clk         => clk,                     -- No Tocar - Entrada del clock completo (100Mhz).
    clock       => clock,                   -- No Tocar - Entrada del clock reducido.
    bussy       => clear,                   -- No Tocar - Salida de la señal de programación.
    ready       => write_rom,               -- No Tocar - Salida de la señal de escritura de la ROM.
    address     => pro_address(11 downto 0),-- No Tocar - Salida de señales del address de la ROM.
    dataout     => rom_datain               -- No Tocar - Salida de señales palabra de entrada de la ROM.
        );
        
-- Fin de declaración de instancias.

-- Fin de declaración de comportamientos.
  
end Behavioral;