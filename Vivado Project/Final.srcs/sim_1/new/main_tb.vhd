library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity main_tb is
end;

architecture bench of main_tb is

  component main
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
  end component;

  signal clk: STD_LOGIC;
  signal reset: STD_LOGIC;
  signal rout0: std_logic_vector(5 downto 0);
  signal rout1: std_logic_vector(5 downto 0);
  signal rout2: std_logic_vector(5 downto 0);
  signal rout3: std_logic_vector(5 downto 0);
  signal routir: std_logic_vector(5 downto 0);
  signal ALURes: signed(5 downto 0);
  signal ZR0: STD_LOGIC :='0';
  signal ZR1: STD_LOGIC :='0';
  signal ZR2: STD_LOGIC :='0';
  signal ZR3: STD_LOGIC :='0';
  signal LDPC: STD_LOGIC;
  signal LDIR: STD_LOGIC;
  signal BUS_Sel: STD_LOGIC;
  signal INC: STD_LOGIC;
  signal RST: STD_LOGIC;
  signal LD0,LD1,LD2,LD3: STD_LOGIC;
  signal state: STD_LOGIC_VECTOR(3 downto 0);

begin

  uut: main port map ( clk     => clk,
                       reset   => reset,
                       rout0   => rout0,
                       rout1   => rout1,
                       rout2   => rout2,
                       rout3   => rout3,
                       routir  => routir,
                       ALURes  => ALURes,
                       ZR0     => ZR0,
                       ZR1     => ZR1,
                       ZR2     => ZR2,
                       ZR3     => ZR3,
                       LDPC    => LDPC,
                       LDIR    => LDIR,
                       BUS_Sel => BUS_Sel,
                       INC     => INC,
                       RST     => RST,
                       LD0     => LD0,
                       LD1     => LD1,
                       LD2     => LD2,
                       LD3     => LD3,
                       state   => state );

    process is
        begin
          clk <= '0';
          wait for 10 ns;
          clk <= '1';
          wait for 10 ns;
    end process;
    zr0   <= '0';
    zr1   <= '0';
    zr2   <= '0';
    zr3   <= '0';
    reset <= '0';
    rout0 <= "000111";
    rout1 <= "001110";
    rout2 <= "011100";
    rout3 <= "101010";
    routir <= "111000";
  stimulus: process
  begin
  
    

    wait;
  end process;


end;
  