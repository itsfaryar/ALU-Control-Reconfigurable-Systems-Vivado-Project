library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity control_unit is
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
end control_unit;



architecture control_arch of control_unit is
type state_type is (s0,s1,s2,s3,s4,s5,s6,s7,s8);
signal p_s , n_s : state_type  ;
begin
-----------------------------------------------------------------
	Present_state:process(CLK,RESET) is	
		begin 
			if (RESET = '1') then
				p_s <= s0 ;
			elsif(rising_edge(CLK)) then
				p_s <= n_s ;
			end if ;
		end process Present_state ;
-----------------------------------------------------------------
	ASM: process(p_s,ZR0,ZR1,ZR2,ZR3,ROUTIR) is
		begin
			case p_s is 
				when s0 => n_s <= s1 ;
				when s2 => n_s <= s2 ;
				when s3 => n_s <= s1 ;
				when s4 => n_s <= s1 ;
				when s5 => n_s <= s1 ;
				when s6 => n_s <= s1 ;
				when s7 => n_s <= s1 ;
				when s1 => n_s <= s8 ;
				when s8 => 
					if (ROUTIR = "000000") then --check halt
						n_s <= s2 ;
					elsif(ROUTIR(5 downto 4) = "00") then --load--
						n_s <= s3 ;
					elsif(ROUTIR(5 downto 4) = "01") then	-- add--
						n_s <= s4 ;
					elsif(ROUTIR(5 downto 4) = "10") then   --sub--
						n_s <= s5 ;
					else     --jnz--
						case ROUTIR(3 downto 2) is 
							when "00" =>
								if(ZR0 = '0') then
									n_s <= s6 ;
								else 
									n_s <= s7 ;	
								end if ;
							when "01" =>
								if(ZR1 = '0') then
									n_s <= s6 ;
								else 
									n_s <= s7 ;
								end if ;
							when "10" =>
								if(ZR2 = '0') then
									n_s <= s6 ;
								else 
									n_s <= s7 ;	 
								end if ;
							when "11" => 
								if(ZR3 = '0') then
									n_s <= s6 ;
								else 
									n_s <= s7 ;
								end if ;
							when others => n_s <= s0 ;
						end case ;
					end if ;
				when others => n_s <= s0;
			end case ;
		end process ASM ;
----------------------------------------------------------------------------------------------
LD0 <= '1' when ((p_s = s3 or p_s = s4 or p_s = s5) and ROUTIR(3 downto 2) = "00") else
	'0' ;
LD1 <= '1' when ((p_s = s3 or p_s = s4 or p_s = s5) and ROUTIR(3 downto 2) = "01") else
	'0' ;
LD2 <= '1' when ((p_s = s3 or p_s = s4 or p_s = s5) and ROUTIR(3 downto 2) = "10") else
	'0' ;
LD3 <= '1' when ((p_s = s3 or p_s = s4 or p_s = s5) and ROUTIR(3 downto 2) = "11") else
	'0' ;



		
LDIR <= '1' when p_s = s1 else
	'0' ;  
	
LDPC <= '1' when p_s = s6 else
	'0' ; 
	
Select0 <= ROUTIR(3 downto 2)  when ( p_s = s4 or p_s = s5 ) else
	"00" ;
	
Select1 <= ROUTIR(1 downto 0) when ( p_s = s4 or p_s = s5 ) else
	"01" ;
	
BUS_Sel <= '1' when ( p_s = s4 or p_s = s5) else
	'0' ; 
		   
CMD <= '1' when (p_s = s5) else
	'0' ;
	
INC <= '1' when(p_s = s1 or p_s = s3 or p_s = s7) else
	'0' ;
	
RST <= '1' when p_s = s0 else 
	'0' ; 
	
state <= "0000" when (p_s = s0) else
"0001" when (p_s = s1) else
"0010" when (p_s = s2) else
"0011" when (p_s = s3) else
"0100" when (p_s = s4) else
"0101" when (p_s = s5) else
"0110" when (p_s = s6) else
"0111" when (p_s = s7) else
"1000" when (p_s = s8) else
"0000" ;
		   
					
			
			
			
			

end control_arch;
