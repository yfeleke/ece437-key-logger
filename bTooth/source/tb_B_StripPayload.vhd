-- $Id: $
-- File name:   tb_B_StripPayload.vhd
-- Created:     4/26/2011
-- Author:      Yonatan Feleke
-- Lab Section: 337-02
-- Version:     1.0  Initial Test Bench

library ieee;
--library gold_lib;   --UNCOMMENT if you're using a GOLD model
use ieee.std_logic_1164.all;
--use gold_lib.all;   --UNCOMMENT if you're using a GOLD model

entity tb_B_StripPayload is
generic (Period : Time := 3.5 ns;
				WAITBIT	:	natural := 658;
				data_period		: Time := 2300 ns);
end tb_B_StripPayload;

architecture TEST of tb_B_StripPayload is

  function INT_TO_STD_LOGIC( X: INTEGER; NumBits: INTEGER )
     return STD_LOGIC_VECTOR is
    variable RES : STD_LOGIC_VECTOR(NumBits-1 downto 0);
    variable tmp : INTEGER;
  begin
    tmp := X;
    for i in 0 to NumBits-1 loop
      if (tmp mod 2)=1 then
        res(i) := '1';
      else
        res(i) := '0';
      end if;
      tmp := tmp/2;
    end loop;
    return res;
  end;

  component B_StripPayload
    PORT(
    		 CLK : in std_logic;
         RST : in std_logic;
         ANTINR : in std_logic;
         READ_EN : in std_logic;
         EMPTY : OUT std_logic;
         REPLY_EN : OUT std_logic;
         ERR : OUT std_logic;
         DATAOUT : OUT std_logic_vector( 7 downto 0)
    );
  end component;

-- Insert signals Declarations here
  signal CLK : std_logic;
  signal RST : std_logic;
  signal ANTINR : std_logic;
  signal READ_EN : std_logic;
  signal EMPTY : std_logic;
  signal REPLY_EN : std_logic;
  signal ERR : std_logic;
  signal DATAOUT : std_logic_vector( 7 downto 0);
  
  type 		test_case_array is array(0 to 4) of std_logic_vector(7 downto 0);	
	constant	test_cases : test_case_array := (	("01010000"),-- acode
																							("01101110"), -- headers...x17
																							("10101010"), -- data
																							("11001010"), -- crc1
																							("01100010")); -- crc2

begin

	CLKGEN: process
  		variable CLK_tmp: std_logic := '0';
		begin
  		CLK_tmp := not CLK_tmp;
  		CLK <= CLK_tmp;
  		wait for Period/2;
		end process;

  DUT: B_StripPayload port map(
                CLK => CLK,
                RST => RST,
                ANTINR => ANTINR,
                READ_EN => READ_EN,
                EMPTY => EMPTY,
                REPLY_EN => REPLY_EN,
                ERR => ERR,
                DATAOUT => DATAOUT
                );
data : process
		variable newsend : std_logic_vector( 7 downto 0);
  begin
  
	-- send accesscode
	    report "Access Code" severity NOTE; 
	  	newsend := test_cases(0);
      for i in 7 downto 0 loop
    	  	ANTINR	<= newsend(i);
					wait for data_period;
	    end loop;	    		
	-- 136 bits of headers
    report "136 bits incoming headers" severity NOTE; 
	  for j in 0 to 17 loop 
	  	newsend := test_cases(1);
      for i in 7 downto 0 loop
    	  	ANTINR	<= newsend(i);
					wait for data_period;
	    end loop;

	  end loop;	
   report "256 bits Data" severity NOTE; 
	-- send data	  
 	  for j in 0 to 32 loop --
	  	newsend := test_cases(2);
      for i in 7 downto 0 loop
    	  	ANTINR	<= newsend(i);
					wait for data_period;
	    end loop;
	  end loop;	
	    report "CRC1 0- 7 incoming" severity NOTE; 
	-- send crc 0-7  of 011001011001010
	  	newsend := test_cases(3);
      for i in 7 downto 0 loop
    	  	ANTINR	<= newsend(i);
					wait for data_period;
	    end loop;
	-- send crc 15-8  of 011001011001010
	    report "CRC2 15-8 incoming" severity NOTE; 
	  	newsend := test_cases(4);
      for i in 7 downto 0 loop
    	  	ANTINR	<= newsend(i);
					wait for data_period;
	    end loop;
	    -- Total cycles 416bits*data_period + 10.5 = 
	    wait;
  end process data;
  
signalprocess : process 
	begin		
    RST <= '1';
    READ_EN <= '0';
    wait for 7 ns;
    RST <= '0';
    READ_EN <= '0';
    wait for 3.5 ns;
    READ_EN <= '1';
    wait;
  end process signalprocess;  
end TEST;