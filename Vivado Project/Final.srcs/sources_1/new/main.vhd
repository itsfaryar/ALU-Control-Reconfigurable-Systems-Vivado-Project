----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2024 10:23:54 PM
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           rout0 : in std_logic_vector(5 downto 0);
           rout1 : in std_logic_vector(5 downto 0);
           rout2 : in std_logic_vector(5 downto 0);
           rout3 : in std_logic_vector(5 downto 0);
           routir : in std_logic_vector(5 downto 0);
           ALURes : out signed(5 downto 0);
           ZR0 : in STD_LOGIC :='0';
           ZR1 : in STD_LOGIC :='0';
           ZR2 : in STD_LOGIC :='0';
           ZR3 : in STD_LOGIC :='0';
           LDPC : out STD_LOGIC;
		   LDIR : out STD_LOGIC;
		   BUS_Sel : out STD_LOGIC;
		   INC : out STD_LOGIC;
		   RST : out STD_LOGIC;
		   LD0,LD1,LD2,LD3 : out STD_LOGIC;
		   state : out STD_LOGIC_VECTOR(3 downto 0));
end main;

architecture Behavioral of main is
component ALU is
	Port ( Rout0 : in  std_logic_vector(5 downto 0);
           Rout1 : in  std_logic_vector(5 downto 0);
           Rout2 : in  std_logic_vector(5 downto 0);
           Rout3 : in  std_logic_vector(5 downto 0);
		   Select0,Select1: in  std_logic_vector(1 downto 0);
           CMD : in STD_LOGIC;
           Result : out signed(5 downto 0));
end component;

component control_unit is
	 port(
		 ZR0 : in STD_LOGIC;
		 ZR1 : in STD_LOGIC;
		 ZR2 : in STD_LOGIC;
		 ZR3 : in STD_LOGIC;
		 CLK : in STD_LOGIC;
		 RESET : in STD_LOGIC;
		 ROUTIR : in STD_LOGIC_VECTOR(5 downto 0);
		 LDPC : out STD_LOGIC;
		 LDIR : out STD_LOGIC;
		 BUS_Sel : out STD_LOGIC;
		 CMD : out STD_LOGIC;
		 INC : out STD_LOGIC;
		 RST : out STD_LOGIC;
		 LD0,LD1,LD2,LD3 : out STD_LOGIC;
		 Select1 : out STD_LOGIC_VECTOR(1 downto 0);
		 Select0 : out STD_LOGIC_VECTOR(1 downto 0);
		 state : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end component;
signal sel0, sel1: STD_LOGIC_VECTOR(1 downto 0);
signal cmd : STD_LOGIC;
begin
alu0: ALU port map(Rout0 => rout0, Rout1 => rout1, Rout2 => rout2, Rout3 => rout3, Select0 => sel0, Select1 => sel1, CMD => cmd, Result => ALURes);

controlUnit0: control_unit port map(ZR0 => ZR0, ZR1 => ZR1, ZR2 => ZR2, ZR3 => ZR3, CLK => clk,
     reset => reset, ROUTIR => routir,
     LDPC => ldpc, LDIR => ldir, BUS_Sel => bus_sel, INC => inc, LD0 => ld0, LD1 => ld1, LD2 => ld2, LD3 => ld3, state => state,
     CMD => cmd, RST => rst, Select1 => sel1, Select0 => sel0);
end Behavioral;
