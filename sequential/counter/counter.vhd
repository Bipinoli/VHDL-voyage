----------------------------------------------------
-- N bit counter
----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

----------------------------------------------------

entity counter is 
  generic (N: natural := 4);
  port (
    clock: in std_logic;
    clear: in std_logic;
    count: in std_logic;
    output: out std_logic_vector(N-1 downto 0)
    );
end counter;


----------------------------------------------------

architecture arc of counter is 
  signal temp_output: std_logic_vector(N-1 downto 0);
begin
  process (clock, clear, count)
  begin
    if clear = '1' then 
      temp_output <= (temp_output'range => '0');
    elsif (clock'event and clock = '1') then
      if count = '1' then 
        temp_output <= temp_output + 1;
      end if ;
    end if;
  end process;

  -- it will run concurrently with process above
  output <= temp_output;

end architecture;

