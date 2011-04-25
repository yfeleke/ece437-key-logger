-- VHDL Entity My_lib.WinningTop.symbol
--
-- Created:
--          by - mg31.bin (ecelinux18.ecn.purdue.edu)
--          at - 04:34:49 04/25/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;

ENTITY WinningTop IS
   PORT( 
      Resend         : IN     std_logic;
      clk            : IN     std_logic;
      dump_filename  : IN     string;
      full           : IN     std_logic;
      init_filename  : IN     string;
      last_address   : IN     natural;
      mem_clr        : IN     boolean;
      mem_dump       : IN     boolean;
      mem_init       : IN     boolean;
      read_enable_in : IN     std_logic;
      rst            : IN     std_logic;
      start_address  : IN     natural;
      verbose        : IN     boolean;
      empty          : OUT    std_logic;
      r_enable_out   : OUT    std_logic;
      data           : INOUT  std_logic_vector (7 DOWNTO 0)
   );

-- Declarations

END WinningTop ;

--
-- VHDL Architecture My_lib.WinningTop.struct
--
-- Created:
--          by - mg31.bin (ecelinux18.ecn.purdue.edu)
--          at - 04:34:49 04/25/11
--
-- Generated by Mentor Graphics' HDL Designer(TM) 2009.2 (Build 10)
--
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE IEEE.std_logic_unsigned.all;
LIBRARY ECE337_IP;
USE ECE337_IP.ALL;

--LIBRARY My_lib;

ARCHITECTURE struct OF WinningTop IS

   -- Architecture declarations

   -- Internal signal declarations
   SIGNAL ADDR         : std_logic_vector(11 DOWNTO 0);
   SIGNAL num_writes   : std_logic;
   SIGNAL r_enable     : std_logic;
   SIGNAL r_enable1    : std_logic;
   SIGNAL read_done    : std_logic;
   SIGNAL read_ready   : std_logic;
   SIGNAL w_enable_in  : std_logic;
   SIGNAL w_enable_out : std_logic;


   -- Component Declarations
   COMPONENT ADDRgen2
   PORT (
      Resend       : IN     std_logic;
      clk          : IN     std_logic;
      r_enable_in  : IN     std_logic;
      read_ready   : IN     std_logic;
      rst          : IN     std_logic;
      w_enable_in  : IN     std_logic;
      ADDR         : OUT    std_logic_vector (11 DOWNTO 0);
      r_enable_out : OUT    std_logic;
      read_done    : OUT    std_logic;
      w_enable_out : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT MemoryController
   PORT (
      clk            : IN     std_logic;
      full           : IN     std_logic;
      read_enable_in : IN     std_logic;
      rst            : IN     std_logic;
      num_writes     : OUT    std_logic;
      r_enable       : OUT    std_logic;
      r_enable_out   : OUT    std_logic;
      w_enable       : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT ReadController2
   PORT (
      clk        : IN     std_logic;
      num_writes : IN     std_logic;
      read_done  : IN     std_logic;
      rst        : IN     std_logic;
      empty      : OUT    std_logic;
      read_ready : OUT    std_logic
   );
   END COMPONENT;
   COMPONENT scalable_off_chip_sram
   PORT (
      addr          : IN     std_logic_vector (11 DOWNTO 0);
      dump_filename : IN     string;
      init_filename : IN     string;
      last_address  : IN     natural;
      mem_clr       : IN     boolean;
      mem_dump      : IN     boolean;
      mem_init      : IN     boolean;
      r_enable      : IN     std_logic;
      start_address : IN     natural;
      verbose       : IN     boolean;
      w_enable      : IN     std_logic;
      data          : INOUT  std_logic_vector (7 DOWNTO 0)
   );
   END COMPONENT;

   -- Optional embedded configurations
   -- pragma synthesis_off
 --  FOR ALL : ADDRgen2 USE ENTITY My_lib.ADDRgen2;
 --  FOR ALL : MemoryController USE ENTITY My_lib.MemoryController;
  -- FOR ALL : ReadController2 USE ENTITY My_lib.ReadController2;
  -- FOR ALL : scalable_off_chip_sram USE ENTITY My_lib.scalable_off_chip_sram;
   -- pragma synthesis_on


BEGIN

   -- Instance port mappings.
   U_0 : ADDRgen2
      PORT MAP (
         clk          => clk,
         rst          => rst,
         Resend       => Resend,
         r_enable_in  => r_enable1,
         w_enable_in  => w_enable_in,
         read_ready   => read_ready,
         ADDR         => ADDR,
         r_enable_out => r_enable,
         w_enable_out => w_enable_out,
         read_done    => read_done
      );
   U_1 : MemoryController
      PORT MAP (
         clk            => clk,
         rst            => rst,
         full           => full,
         read_enable_in => read_enable_in,
         r_enable       => r_enable1,
         w_enable       => w_enable_in,
         r_enable_out   => r_enable_out,
         num_writes     => num_writes
      );
   U_2 : ReadController2
      PORT MAP (
         rst        => rst,
         clk        => clk,
         num_writes => num_writes,
         read_done  => read_done,
         empty      => empty,
         read_ready => read_ready
      );
   U_3 : scalable_off_chip_sram
      PORT MAP (
         mem_clr       => mem_clr,
         mem_init      => mem_init,
         mem_dump      => mem_dump,
         verbose       => verbose,
         init_filename => init_filename,
         dump_filename => dump_filename,
         start_address => start_address,
         last_address  => last_address,
         r_enable      => r_enable,
         w_enable      => w_enable_out,
         addr          => ADDR,
         data          => data
      );

END struct;