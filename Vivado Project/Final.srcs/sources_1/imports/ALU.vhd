library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;


entity ALU is
	Port ( Rout0 : in  std_logic_vector(5 downto 0);
           Rout1 : in  std_logic_vector(5 downto 0);
           Rout2 : in  std_logic_vector(5 downto 0);
           Rout3 : in  std_logic_vector(5 downto 0);
		   Select0,Select1: in  std_logic_vector(1 downto 0);
           CMD : in STD_LOGIC;
           Result : out signed(5 downto 0));
end ALU;


architecture ALU of ALU is 
signal IN1 : signed(5 downto 0);
signal IN2 : signed(5 downto 0); 
signal temp : signed(5 downto 0) ;
begin	 
	
-- multi process	   

process(Rout0,Rout1,Rout2,Rout3,Select0) is  

begin	  
   if (Select0="00" ) then 
		IN1 <= signed(Rout0); 
   elsif (Select0 = "01" ) then
     IN1 <= signed(Rout1);
   elsif (Select0 = "10" ) then
     IN1 <= signed(Rout2);	 
  elsif (Select0 = "11" ) then
     IN1 <= signed(Rout3);
  end if;
  end process; 

  
  process(Rout0,Rout1,Rout2,Rout3,Select1) is  
  begin	  
	  if (Select1 = "00" ) then
	     IN2 <= signed(Rout0);
	  elsif (Select1 = "01" ) then
	     IN2 <= signed(Rout1);
	  elsif (Select1 = "10" ) then
	     IN2 <= signed(Rout2);	 
	  elsif (Select1 = "11" ) then
	     IN2 <= signed(Rout3);
	  end if;
  end process; 

-- alu process
 process(IN1,IN2,CMD)  
	
  begin
	case CMD is
	    when '0' =>
	       Result <= IN1 + IN2; --addition
	    when '1' =>	
			if (IN1 = "000000") then 
				Result <= "000000" ;
			else
		       	Result <= IN1 - IN2; --subtraction
			end if ;
	 	when others => NULL; 
	end case;  
end process;	


end ALU;
