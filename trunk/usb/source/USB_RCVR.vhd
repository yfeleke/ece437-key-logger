-- VHDL Entity USB_keylogger_lib.USB_RCVR.symbol
--
-- Created:
--          by - mg32.bin (ecelinux17.ecn.purdue.edu)
--          at - 06:08:47 04/25/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY USB_RCVR IS
   PORT( 
      CLK      : IN     std_logic;
      D_MINUS  : IN     std_logic;
      D_PLUS   : IN     std_logic;
      RST      : IN     std_logic;
      R_ENABLE : IN     std_logic;
      EMPTY    : OUT    std_logic;
      FULL     : OUT    std_logic;
      R_DATA   : OUT    std_logic_vector (7 DOWNTO 0);
      r_error  : OUT    std_logic;
      rcving   : OUT    std_logic
   );

-- Declarations

END USB_RCVR ;

--
-- VHDL Architecture USB_keylogger_lib.USB_RCVR.struct
--
-- Created:
--          by - mg32.bin (ecelinux17.ecn.purdue.edu)
--          at - 06:08:48 04/25/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
LIBRARY ECE337_IP;
USE ECE337_IP.ALL;

--LIBRARY USB_keylogger_lib;

ARCHITECTURE struct OF USB_RCVR IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL CRC_EN       : std_logic;
   SIGNAL CRC_ERROR    : std_logic;
   SIGNAL CRC_SHIFT    : std_logic;
   SIGNAL D_CLK        : std_logic;
   SIGNAL EOP          : std_logic;
   SIGNAL RCV_DATA     : std_logic_vector(7 DOWNTO 0);
   SIGNAL SHIFT_ENABLE : std_logic;
   SIGNAL STUFF_ERROR  : std_logic;
   SIGNAL W_DATA       : std_logic_vector(7 DOWNTO 0);
   SIGNAL W_ENABLE_OUT : std_logic;
   SIGNAL d_edge       : std_logic;
   SIGNAL d_orig       : std_logic;
   SIGNAL dout         : std_logic;
   SIGNAL w_enable     : std_logic;

   -- Implicit buffer signal declarations
   SIGNAL rcving_internal : std_logic;


   -- Component Declarations
   COMPONENT RCV_FIFO
   PORT (
      CLK      : IN     std_logic;
      D_CLK    : IN     std_logic;
      RST_N    : IN     std_logic;
      R_ENABLE : IN     std_logic;
      WDATA    : IN     std_logic_vector (7 DOWNTO 0);
      W_ENABLE : IN     std_logic;
      EMPTY    : OUT    std_logic;
      FULL     : OUT    std_logic;
      R_DATA   : OUT    std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT USB_SHIFT
   PORT (
      D_CLK          : IN     std_logic;
      D_ORIG       : IN     std_logic;
      EOP          : IN     std_logic;
      RST          : IN     std_logic;
      SHIFT_ENABLE : IN     std_logic;
      CRC_SHIFT    : OUT    std_logic;
      RCV_DATA     : OUT    std_logic_vector (7 DOWNTO 0);
      STUFF_ERROR  : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_BUFFER
   PORT (
      D_CLK        : IN     std_logic;
      EOP          : IN     std_logic;
      RCV_DATA     : IN     std_logic_vector (7 DOWNTO 0);
      RST          : IN     std_logic;
      W_ENABLE     : IN     std_logic;
      W_DATA       : OUT    std_logic_vector (7 DOWNTO 0);
      W_ENABLE_OUT : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_CLKDIV
   PORT (
      CLK   : IN     std_logic;
      RST   : IN     std_logic;
      D_CLK : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_CRC
   PORT (
      D_CLK       : IN     std_logic;
      CRC_EN    : IN     std_logic;
      CRC_SHIFT : IN     std_logic;
      D_ORIG    : IN     std_logic;
      RST_N     : IN     std_logic;
      CRC_ERROR : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_DECODE
   PORT (
      D_clk          : IN     std_logic;
      d_plus       : IN     std_logic;
      eop          : IN     std_logic;
      rst_n        : IN     std_logic;
      shift_enable : IN     std_logic;
      d_orig       : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_EDGE_DETECT
   PORT (
      D_clk    : IN     std_logic;
      d_plus : IN     std_logic;
      rst_n  : IN     std_logic;
      d_edge : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_EOP_DETECT
   PORT (
      D_MINUS : IN     std_logic;
      D_PLUS  : IN     std_logic;
      EOP     : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_RCU
   PORT (
      CRC_ERROR    : IN     std_logic;
      STUFF_ERROR  : IN     std_logic;
      D_clk          : IN     std_logic;
      d_edge       : IN     std_logic;
      eop          : IN     std_logic;
      rcv_data     : IN     std_logic_vector (7 DOWNTO 0);
      rst_n        : IN     std_logic;
      shift_enable : IN     std_logic;
      CRC_EN       : OUT    std_logic;
      r_error      : OUT    std_logic;
      rcving       : OUT    std_logic;
      w_enable     : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT U_TIMER
   PORT (
      D_CLK          : IN     std_logic;
      D_EDGE       : IN     std_logic;
      RCVING       : IN     std_logic;
      RST_N        : IN     std_logic;
      SHIFT_ENABLE : OUT    std_logic
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   --FOR ALL : RCV_FIFO USE ENTITY USB_keylogger_lib.RCV_FIFO;
   --FOR ALL : USB_SHIFT USE ENTITY USB_keylogger_lib.USB_SHIFT;
   --FOR ALL : U_BUFFER USE ENTITY USB_keylogger_lib.U_BUFFER;
   --FOR ALL : U_CLKDIV USE ENTITY USB_keylogger_lib.U_CLKDIV;
   --FOR ALL : U_CRC USE ENTITY USB_keylogger_lib.U_CRC;
   --FOR ALL : U_DECODE USE ENTITY USB_keylogger_lib.U_DECODE;
   --FOR ALL : U_EDGE_DETECT USE ENTITY USB_keylogger_lib.U_EDGE_DETECT;
   --FOR ALL : U_EOP_DETECT USE ENTITY USB_keylogger_lib.U_EOP_DETECT;
   --FOR ALL : U_RCU USE ENTITY USB_keylogger_lib.U_RCU;
   --FOR ALL : U_TIMER USE ENTITY USB_keylogger_lib.U_TIMER;
   -- pragma synthesis_on


BEGIN

   -- ModuleWare code(v1.9) for instance 'U_9' of 'inv'
   dout <= NOT(RST);

   -- Instance port mappings.
   U_5 : RCV_FIFO
      PORT MAP (
         CLK      => CLK,
         D_CLK    => D_CLK,
         RST_N    => dout,
         R_ENABLE => R_ENABLE,
         W_ENABLE => W_ENABLE_OUT,
         WDATA    => W_DATA,
         R_DATA   => R_DATA,
         EMPTY    => EMPTY,
         FULL     => FULL
      );
   U_7 : USB_SHIFT
      PORT MAP (
         D_CLK          => D_CLK,
         RST          => RST,
         EOP          => EOP,
         SHIFT_ENABLE => SHIFT_ENABLE,
         D_ORIG       => d_orig,
         RCV_DATA     => RCV_DATA,
         CRC_SHIFT    => CRC_SHIFT,
         STUFF_ERROR  => STUFF_ERROR
      );
   U_10 : U_BUFFER
      PORT MAP (
         D_CLK        => D_CLK,
         RST          => RST,
         W_ENABLE     => w_enable,
         EOP          => EOP,
         W_ENABLE_OUT => W_ENABLE_OUT,
         RCV_DATA     => RCV_DATA,
         W_DATA       => W_DATA
      );
   U_8 : U_CLKDIV
      PORT MAP (
         CLK   => CLK,
         RST   => RST,
         D_CLK => D_CLK
      );
   U_0 : U_CRC
      PORT MAP (
         D_CLK       => D_CLK,
         RST_N     => RST,
         CRC_SHIFT => CRC_SHIFT,
         D_ORIG    => d_orig,
         CRC_EN    => CRC_EN,
         CRC_ERROR => CRC_ERROR
      );
   U_1 : U_DECODE
      PORT MAP (
         D_clk          => D_CLK,
         rst_n        => RST,
         d_plus       => D_PLUS,
         shift_enable => SHIFT_ENABLE,
         eop          => EOP,
         d_orig       => d_orig
      );
   U_2 : U_EDGE_DETECT
      PORT MAP (
         D_clk    => D_CLK,
         rst_n  => RST,
         d_plus => D_PLUS,
         d_edge => d_edge
      );
   U_3 : U_EOP_DETECT
      PORT MAP (
         D_PLUS  => D_PLUS,
         D_MINUS => D_MINUS,
         EOP     => EOP
      );
   U_4 : U_RCU
      PORT MAP (
         D_clk          => D_CLK,
         rst_n        => RST,
         d_edge       => d_edge,
         eop          => EOP,
         CRC_ERROR    => CRC_ERROR,
         STUFF_ERROR  => STUFF_ERROR,
         shift_enable => CRC_SHIFT,
         rcv_data     => RCV_DATA,
         rcving       => rcving_internal,
         w_enable     => w_enable,
         r_error      => r_error,
         CRC_EN       => CRC_EN
      );
   U_6 : U_TIMER
      PORT MAP (
         D_CLK          => D_CLK,
         RST_N        => RST,
         D_EDGE       => d_edge,
         RCVING       => rcving_internal,
         SHIFT_ENABLE => SHIFT_ENABLE
      );

   -- Implicit buffered output assignments
   rcving <= rcving_internal;

END struct;