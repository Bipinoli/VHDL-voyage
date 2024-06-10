----------------------------------------------------
-- Testbench for N bit counter 
----------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use ieee.std_logic_unsigned.all;

----------------------------------------------------

entity counter_testbench_entity is
end counter_testbench_entity;

----------------------------------------------------

architecture testbench of counter_testbench_entity is
  
  component counter is 
    generic (N: natural := 4);
    port (
      clock: in std_logic;
      clear: in std_logic;
      count: in std_logic;
      output: out std_logic_vector(N-1 downto 0)
      );
  end component;

  signal t_clock: std_logic;
  signal t_clear: std_logic;
  signal t_count: std_logic;
  signal t_output: std_logic_vector(5 downto 0);

begin

  counter_instance:
    counter generic map (N => 6)
            port map (clock => t_clock, clear => t_clear, count => t_count, output => t_output);

  process 
  begin
    -- clock signal generator (20 ns time period)
    t_clock <= '0';
    wait for 10 ns;
    t_clock <= '1';
    wait for 10 ns;
  end process;

  process 
  begin

    t_clear <= '1';
    wait for 20 ns;

    t_clear <= '0';
    t_count <= '1';

    -- after a clock cycle
    wait for 20 ns;
    assert (t_output = 1) report "Failed to count from 0 to 1" severity error;

    wait for 20 ns;
    assert (t_output = 2) report "Failed to count from 1 to 2" severity error;

    wait for 40 ns;
    assert (t_output = 4) report "Failed to count to 4" severity error;

    wait for 80 ns;
    assert (t_output = 8) report "Failed to count to 8" severity error;

    -- full circle back
    wait for 1280 ns;
    assert (t_output = 8) report "Failed to full circle" severity error;

    wait;
  end process;

end architecture;


----------------------------------------------------

configuration conf_testbench of counter_testbench_entity is
  for testbench
  end for;
end conf_testbench;

