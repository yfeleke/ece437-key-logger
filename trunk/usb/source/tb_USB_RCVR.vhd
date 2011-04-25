-- $Id: $
-- File name:   tb_USB_RCVR.vhd
-- Created:     4/24/2011
-- Author:      Brian Crone
-- Lab Section: 337-02
-- Version:     1.0  Initial Test Bench

library ieee;
--library gold_lib;   --UNCOMMENT if you're using a GOLD model
use ieee.std_logic_1164.all;
--use gold_lib.all;   --UNCOMMENT if you're using a GOLD model

entity tb_USB_RCVR is
generic (Period : Time := 3.4722 ns;
				 Period2 :	Time := 10.4167 ns);
end tb_USB_RCVR;

architecture TEST of tb_USB_RCVR is

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
	function NRZIencode(DATA: std_logic_vector; Prevbit: std_logic)
		return	STD_LOGIC_VECTOR is
		variable encoded: std_logic_vector(7 downto 0) := "00000000";
	begin
		if (DATA(0) = '1') then encoded(0) := Prevbit;
		else encoded(0) := not(Prevbit);
		end if;
		for I in 1 to 7 loop
			if(DATA(I) = '1') then encoded(I) := encoded(I-1);
			else encoded(I) := not(encoded(I-1));
			end if;
		end loop;
		return encoded;
	end;

  component USB_RCVR
    PORT(
         CLK : IN std_logic;
         D_MINUS : IN std_logic;
         D_PLUS : IN std_logic;
         RST : IN std_logic;
         R_ENABLE : IN std_logic;
         EMPTY : OUT std_logic;
         FULL : OUT std_logic;
         R_DATA : OUT std_logic_vector (7 DOWNTO 0);
         r_error : OUT std_logic;
         rcving : OUT std_logic
    );
  end component;

-- Insert signals Declarations here
  signal CLK : std_logic;
  signal D_MINUS : std_logic;
  signal D_PLUS : std_logic;
  signal RST : std_logic;
  signal R_ENABLE : std_logic;
  signal EMPTY : std_logic;
  signal FULL : std_logic;
  signal R_DATA : std_logic_vector (7 DOWNTO 0);
  signal r_error : std_logic;
  signal rcving : std_logic;
	signal testvector	:	std_logic_vector(7 downto 0);
	

	procedure outputdata(
		constant data : in std_logic_vector(7 downto 0);
		constant DATA_RATE : in time;
		signal output : inout std_logic;
		signal minus : inout std_logic) is
		begin
		for i in 0 to DATA'length -1 loop
			output <= data(i);
			minus <= not(data(i));
			wait for DATA_RATE;
			--if ( i = 0) then edge<= '1';
			--elsif (data(i) = data(i-1)) then edge <= '0';
			--else edge <= '1';
			--end if;
			--wait for period;
			--edge <= '0';
			--wait for 6*period;
		end loop;
	END PROCEDURE outputdata; 

-- signal <name> : <type>;

begin

CLKGEN: process
  variable CLK_tmp: std_logic := '0';
begin
  CLK_tmp := not CLK_tmp;
  CLK <= CLK_tmp;
  wait for Period/2;
end process;

  DUT: USB_RCVR port map(
                CLK => CLK,
                D_MINUS => D_MINUS,
                D_PLUS => D_PLUS,
                RST => RST,
                R_ENABLE => R_ENABLE,
                EMPTY => EMPTY,
                FULL => FULL,
                R_DATA => R_DATA,
                r_error => r_error,
                rcving => rcving
                );

--   GOLD: <GOLD_NAME> port map(<put mappings here>);

process
	variable TestByte : std_logic_vector(7 downto 0);
	variable SYNC	:	std_logic_vector(7 downto 0) := "10000000";
	variable DATA0	:	std_logic_vector(7 downto 0) := "11000011";
	variable DATA1	:	std_logic_vector(7 downto 0) := "01001011";
  begin

-- Insert TEST BENCH Code Here

    D_MINUS <= '0';

    D_PLUS <= '1';

    RST <= '0';

    R_ENABLE <= '0';

    wait for Period2;
    RST <= '1';
    wait for Period2*8;
    RST <= '0';
		--wait for Period2*8;
		--D_PLUS <= '0';
		--D_MINUS <= '1';
		--wait for Period2*8;
		--TestByte := NRZIencode("10000000",'1');
		--for I in 0 to 7 loop
		--	D_PLUS <= TestByte(I);
		--	D_MINUS <= not(TestByte(I));
		--	wait for Period2*8;
		--end loop;
    outputdata(NRZIencode(SYNC,'1'),Period2*8,D_PLUS,D_MINUS);
    outputdata(NRZIencode(DATA1,'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("01011100",'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("10101001",'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("01011100",'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("10010101",'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("00001111",'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("11001101",'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("00000000",'0'),Period2*8,D_PLUS,D_MINUS);
		outputdata(NRZIencode("11110000",'0'),Period2*8,D_PLUS,D_MINUS);
		wait;
  end process;
end TEST;
