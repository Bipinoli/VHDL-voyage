-------------------------------------------------------
-- ALU 
-- can perform add, subtract (2s completement addition), logical and, or.
-- 2 bit input output, carry ignored
-- Based on Weijun Zhang's code from : http://esd.cs.ucr.edu/labs/tutorial/
-------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-------------------------------------------------------

entity ALU is
port (
      A: in std_logic_vector(1 downto 0);
      B: in std_logic_vector(1 downto 0);
      sel: in std_logic_vector(1 downto 0);
      output: out std_logic_vector(1 downto 0)
      );
end ALU;


-------------------------------------------------------

architecture arc of ALU is 
begin 
  process (A, B, sel)
  begin
    case sel is
      when "00" => output <= A + B;
      when "01" => output <= A + (not B) + 1; -- not B + 1 = 2's completement of B
      when "10" => output <= A and B;
      when "11" => output <= A or B;
      when others => output <= "XX";
    end case;
  end process;
end arc;

-------------------------------------------------------


