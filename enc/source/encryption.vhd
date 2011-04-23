-- VHDL Entity My_Lib.ENCRYPTION.symbol
--
-- Created:
--          by - mg34.bin (ecelinux27.ecn.purdue.edu)
--          at - 03:48:26 04/22/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY ENCRYPTION IS
   PORT( 
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

-- Declarations

END ENCRYPTION ;

--
-- VHDL Architecture My_Lib.ENCRYPTION.struct
--
-- Created:
--          by - mg34.bin (ecelinux27.ecn.purdue.edu)
--          at - 03:48:26 04/22/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;
USE IEEE.NUMERIC_BIT.all;
LIBRARY ECE337_IP;
USE ECE337_IP.ALL;

--LIBRARY My_Lib;

ARCHITECTURE struct OF ENCRYPTION IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL DATA1      : std_logic_vector(7 DOWNTO 0);
   SIGNAL ENC_LEFT   : std_logic_vector(31 DOWNTO 0);
   SIGNAL ENC_RIGHT  : std_logic_vector(31 DOWNTO 0);
   SIGNAL FIESTELCLK : std_logic;
   SIGNAL IN_SELECT  : std_logic;
   SIGNAL OUTDATA    : std_logic_vector(63 DOWNTO 0);
   SIGNAL RKEY       : std_logic_vector(47 DOWNTO 0);
   SIGNAL RND_CNT    : std_logic_vector(3 DOWNTO 0);
   SIGNAL START      : std_logic;
   SIGNAL W_ENABLE   : std_logic;
   SIGNAL W_ENABLE1  : std_logic;


   -- Component Declarations
   COMPONENT RCV_FIFO
   PORT (
      CLK      : IN     std_logic;
      RST_N    : IN     std_logic;
      R_ENABLE : IN     std_logic;
      WDATA    : IN     std_logic_vector (7 DOWNTO 0);
      W_ENABLE : IN     std_logic;
      EMPTY    : OUT    std_logic;
      FULL     : OUT    std_logic;
      R_DATA   : OUT    std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT e_DeCompile
   PORT (
      CLK      : IN     std_logic;
      D_ENABLE : IN     std_logic;
      OUTDATA  : IN     std_logic_vector (63 DOWNTO 0);
      DATA     : OUT    std_logic_vector (7 DOWNTO 0);
      W_ENABLE : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT e_encController
   PORT (
      CLK       : IN     std_logic;
      DATA      : IN     std_logic_vector (7 DOWNTO 0);
      EMPTY     : IN     std_logic;
      FULL      : IN     std_logic;
      RST       : IN     std_logic;
      ENC_LEFT  : OUT    std_logic_vector (31 DOWNTO 0);
      ENC_RIGHT : OUT    std_logic_vector (31 DOWNTO 0);
      R_ENABLE  : OUT    std_logic;
      START     : OUT    std_logic;
      W_ENABLE  : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT e_fiestel
   PORT (
      ENC_LEFT   : IN     std_logic_vector (31 DOWNTO 0);
      ENC_RIGHT  : IN     std_logic_vector (31 DOWNTO 0);
      FIESTELCLK : IN     std_logic;
      IN_SELECT  : IN     std_logic;
      RKEY       : IN     std_logic_vector (47 DOWNTO 0);
      START      : IN     std_logic;
      OUTDATA    : OUT    std_logic_vector (63 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT e_rkeyGen
   PORT (
      CLK       : IN     std_logic;
      IN_SELECT : IN     std_logic;
      RNDNUM    : IN     std_logic_vector (3 DOWNTO 0);
      START_RST : IN     std_logic;
      RKEY      : OUT    std_logic_vector (47 DOWNTO 0)
   );
   END COMPONENT;
   COMPONENT e_rndCount
   PORT (
      CLK        : IN     std_logic;
      RST        : IN     std_logic;
      START      : IN     std_logic;
      FIESTELCLK : OUT    std_logic;
      IN_SELECT  : OUT    std_logic;
      RND_CNT    : OUT    std_logic_vector (3 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
   --FOR ALL : RCV_FIFO USE ENTITY My_Lib.RCV_FIFO;
   --FOR ALL : e_DeCompile USE ENTITY My_Lib.e_DeCompile;
   --FOR ALL : e_encController USE ENTITY My_Lib.e_encController;
   --FOR ALL : e_fiestel USE ENTITY My_Lib.e_fiestel;
   --FOR ALL : e_rkeyGen USE ENTITY My_Lib.e_rkeyGen;
   --FOR ALL : e_rndCount USE ENTITY My_Lib.e_rndCount;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   U_5 : RCV_FIFO
      PORT MAP (
         CLK      => CLK,
         RST_N    => RST,
         R_ENABLE => RENABLE,
         W_ENABLE => W_ENABLE1,
         WDATA    => DATA1,
         R_DATA   => RDATA,
         EMPTY    => EMPTY1,
         FULL     => FULL1
      );
   U_0 : e_DeCompile
      PORT MAP (
         OUTDATA  => OUTDATA,
         D_ENABLE => W_ENABLE,
         CLK      => CLK,
         DATA     => DATA1,
         W_ENABLE => W_ENABLE1
      );
   U_1 : e_encController
      PORT MAP (
         DATA      => DATA,
         FULL      => FULL,
         EMPTY     => EMPTY,
         CLK       => CLK,
         RST       => RST,
         START     => START,
         R_ENABLE  => R_ENABLE,
         W_ENABLE  => W_ENABLE,
         ENC_LEFT  => ENC_LEFT,
         ENC_RIGHT => ENC_RIGHT
      );
   U_2 : e_fiestel
      PORT MAP (
         FIESTELCLK => FIESTELCLK,
         START      => START,
         ENC_LEFT   => ENC_LEFT,
         ENC_RIGHT  => ENC_RIGHT,
         RKEY       => RKEY,
         IN_SELECT  => IN_SELECT,
         OUTDATA    => OUTDATA
      );
   U_3 : e_rkeyGen
      PORT MAP (
         RNDNUM    => RND_CNT,
         START_RST => START,
         IN_SELECT => IN_SELECT,
         CLK       => CLK,
         RKEY      => RKEY
      );
   U_4 : e_rndCount
      PORT MAP (
         CLK        => CLK,
         RST        => RST,
         START      => START,
         IN_SELECT  => IN_SELECT,
         FIESTELCLK => FIESTELCLK,
         RND_CNT    => RND_CNT
      );

END struct;
