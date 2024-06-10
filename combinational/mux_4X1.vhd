-------------------------------------------------------
-- 4:1 Mux with 3 bit input and output ports
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-------------------------------------------------------

entity Mux is
port (
      sel: in std_logic_vector(1 downto 0);
      in0: in std_logic_vector(2 downto 0);
      in1: in std_logic_vector(2 downto 0);
      in2: in std_logic_vector(2 downto 0);
      in3: in std_logic_vector(2 downto 0);
      output: out std_logic_vector(2 downto 0)
     );
end Mux;

-------------------------------------------------------

architecture arc1 of Mux is
begin 
  process (sel, in0, in1, in2, in3)
  begin
    case sel is
      when "00" => output <= in0;
      when "01" => output <= in1;
      when "10" => output <= in2;
      when "11" => output <= in3;
      when others => output <= "ZZZ";
    end case;
  end process;
end arc1;


architecture arc2 of Mux is
begin
  output <= in0 when sel = "00" else 
            in1 when sel = "01" else 
            in2 when sel = "10" else 
            in3 when sel = "11" else 
            "ZZZ";
end arc2;

-------------------------------------------------------


