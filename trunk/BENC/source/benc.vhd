-- VHDL Entity BTOOTH_LIB1.BENC.symbol
--
-- Created:
--          by - mg34.bin (ecelinux17.ecn.purdue.edu)
--          at - 14:10:20 04/26/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY BENC IS
   PORT( 
      CLK          : IN     std_logic;
      D_MINUS      : IN     std_logic;
      D_PLUS       : IN     std_logic;
      READ_EN1     : IN     std_logic;
      RST          : IN     std_logic;
      ADDR         : OUT    std_logic_vector (11 DOWNTO 0);
      DATAOUT      : OUT    std_logic_vector ( 7 DOWNTO 0);
      EMPTY_SRAM   : OUT    std_logic;
      SDATA        : INOUT    std_logic_vector (7 DOWNTO 0);
      r_enable_s   : OUT    std_logic;
      r_error      : OUT    std_logic;
      rcving       : OUT    std_logic;
      w_enable_out : OUT    std_logic
   );

-- Declarations

END BENC ;

--
-- VHDL Architecture BTOOTH_LIB1.BENC.struct
--
-- Created:
--          by - mg34.bin (ecelinux17.ecn.purdue.edu)
--          at - 14:10:20 04/26/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;

--LIBRARY BTOOTH_LIB1;

ARCHITECTURE struct OF BENC IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL DATA         : std_logic_vector(7 DOWNTO 0);
   SIGNAL EMPTY        : std_logic;
   SIGNAL FULL         : std_logic;
   SIGNAL FULL1        : std_logic;
   SIGNAL RDATA        : std_logic_vector(7 DOWNTO 0);
   SIGNAL R_DATA       : std_logic_vector(7 DOWNTO 0);
   SIGNAL R_ENABLE     : std_logic;
   SIGNAL empty1       : std_logic;
   SIGNAL r_enable_in  : std_logic;
   SIGNAL r_enable_out : std_logic;
   SIGNAL resend       : std_logic;


   -- Component Declarations
   COMPONENT encryption
   PORT (
      CLK      : IN     std_logic;
      DATA     : IN     std_logic_vector (7 DOWNTO 0);
      EMPTY    : IN     std_logic;
      FULL     : IN     std_logic;
      RENABLE  : IN     std_logic;
      RST      : IN     std_logic;
      EMPTY1   : OUT    std_logic;
      FULL1    : OUT    std_logic;
      RDATA    : OUT    std_logic_vector (7 DOWNTO 0);
      R_ENABLE : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT USB_RCVR
   PORT (
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
   END COMPONENT;
   COMPONENT bToothTop
   PORT (
      CLK        : IN     std_logic;
      DATA       : IN     std_logic_vector (7 DOWNTO 0);
      EMPTY      : IN     std_logic;
      READ_EN1   : IN     std_logic;
      RST        : IN     std_logic;
      DATAOUT    : OUT    std_logic_vector ( 7 DOWNTO 0);
      EMPTY_SRAM : OUT    std_logic;
      READ_EN    : OUT    std_logic;
      RESEND_EN  : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT s_Control
   PORT (
      IDATA        : IN     std_logic_vector (7 DOWNTO 0);
      clk          : IN     std_logic;
      full         : IN     std_logic;
      r_enable_in  : IN     std_logic;
      resend       : IN     std_logic;
      rst          : IN     std_logic;
      ADDR         : OUT    std_logic_vector (11 DOWNTO 0);
      ODATA        : OUT    std_logic_vector (7 DOWNTO 0);
      SDATA        : INOUT    std_logic_vector (7 DOWNTO 0);
      empty        : OUT    std_logic;
      r_enable_out : OUT    std_logic;
      r_enable_s   : OUT    std_logic;
      w_enable_out : OUT    std_logic
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   --FOR ALL : ENCRYPTION USE ENTITY BTOOTH_LIB1.ENCRYPTION;
   --FOR ALL : USB_RCVR USE ENTITY BTOOTH_LIB1.USB_RCVR;
   --FOR ALL : bToothTop USE ENTITY BTOOTH_LIB1.bToothTop;
   --FOR ALL : s_Control USE ENTITY BTOOTH_LIB1.s_Control;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   U_0 : ENCRYPTION
      PORT MAP (
         CLK      => CLK,
         DATA     => R_DATA,
         EMPTY    => EMPTY,
         FULL     => FULL,
         RENABLE  => r_enable_out,
         RST      => RST,
         EMPTY1   => OPEN,
         FULL1    => FULL1,
         RDATA    => RDATA,
         R_ENABLE => R_ENABLE
      );
   U_1 : USB_RCVR
      PORT MAP (
         CLK      => CLK,
         D_MINUS  => D_MINUS,
         D_PLUS   => D_PLUS,
         RST      => RST,
         R_ENABLE => R_ENABLE,
         EMPTY    => EMPTY,
         FULL     => FULL,
         R_DATA   => R_DATA,
         r_error  => r_error,
         rcving   => rcving
      );
   U_2 : bToothTop
      PORT MAP (
         CLK        => CLK,
         DATA       => DATA,
         EMPTY      => empty1,
         READ_EN1   => READ_EN1,
         RST        => RST,
         DATAOUT    => DATAOUT,
         EMPTY_SRAM => EMPTY_SRAM,
         READ_EN    => r_enable_in,
         RESEND_EN  => resend
      );
   U_3 : s_Control
      PORT MAP (
         clk          => CLK,
         rst          => RST,
         full         => FULL1,
         resend       => resend,
         r_enable_in  => r_enable_in,
         IDATA        => RDATA,
         empty        => empty1,
         r_enable_out => r_enable_out,
         r_enable_s   => r_enable_s,
         ADDR         => ADDR,
         ODATA        => DATA,
         SDATA        => SDATA,
         w_enable_out => w_enable_out
      );

END struct;