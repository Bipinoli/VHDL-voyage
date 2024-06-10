------------------------------------------------------------
-- Test Bench for 4:1 Mux with 3bit input and output ports
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Mux_testbench is
end Mux_testbench;

------------------------------------------------------------

architecture testbench of Mux_testbench is 

  -- initialize signals
  signal t_sel: std_logic_vector(1 downto 0);
  signal t_output: std_logic_vector(2 downto 0);
  signal t_in0: std_logic_vector(2 downto 0) := "000";
  signal t_in1: std_logic_vector(2 downto 0) := "000";
  signal t_in2: std_logic_vector(2 downto 0) := "000";
  signal t_in3: std_logic_vector(2 downto 0) := "000";

  component Mux is
  port (
        sel: in std_logic_vector(1 downto 0);
        in0: in std_logic_vector(2 downto 0);
        in1: in std_logic_vector(2 downto 0);
        in2: in std_logic_vector(2 downto 0);
        in3: in std_logic_vector(2 downto 0);
        output: out std_logic_vector(2 downto 0)
      );
  end component;

begin

  mux_instance: Mux port map (sel => t_sel, in0 => t_in0, in1 => t_in1, in2 => t_in2, in3 => t_in3, output => t_output);

  process 
    variable err_cnt: integer := 0;

  begin

    t_in0 <= "001";
    t_in1 <= "010";
    t_in2 <= "100";
    t_in3 <= "110";

    -- test 1
    wait for 10 ns;
    t_sel <= "00";
    wait for 1 ns;
    assert (t_output = "001") report "Didn't select in0 properly" severity error;
    if (t_output /= "001") then
      err_cnt := err_cnt + 1;
    end if;

    -- test 2
    wait for 10 ns;
    t_sel <= "10";
    wait for 1 ns;
    assert (t_output = "100") report "Didn't select in2 properly" severity error;
    if (t_output /= "100") then
      err_cnt := err_cnt + 1;
    end if;

    -- summary of tests
    if (err_cnt = 0) then 
      assert (false) report "All tests passed!" severity note;
    else 
      assert (true) report integer'image(err_cnt) & "Tests failed!" severity error;
    end if;

    -- wait forever
    wait;

end process;

end testbench;


------------------------------------------------------------

configuration configure_testbench of Mux_testbench is
  for testbench 
    end for;
end configure_testbench;
