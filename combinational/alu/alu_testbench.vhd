------------------------------------------------------------
-- Test Bench for ALU 
------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU_testbench_entity is
end ALU_testbench_entity;

------------------------------------------------------------

architecture testbench of ALU_testbench_entity is 

  -- initialize signals
  signal t_sel: std_logic_vector(1 downto 0);
  signal t_output: std_logic_vector(1 downto 0);
  signal t_a: std_logic_vector(1 downto 0) := "01";
  signal t_b: std_logic_vector(1 downto 0) := "01";

  component ALU is
  port (
        A: in std_logic_vector(1 downto 0);
        B: in std_logic_vector(1 downto 0);
        sel: in std_logic_vector(1 downto 0);
        output: out std_logic_vector(1 downto 0)
        );
  end component;

begin

  alu_instance: ALU port map (sel => t_sel, A => t_a, B => t_b, output => t_output);

  process 
    variable err_cnt: integer := 0;

  begin

    -- test 1: Add
    wait for 10 ns;
    t_sel <= "00";
    wait for 1 ns;
    assert (t_output = "10") report "Add failed" severity error;
    if (t_output /= "10") then
      err_cnt := err_cnt + 1;
    end if;

    -- test 2: Sub
    wait for 10 ns;
    t_a <= "10";
    t_sel <= "01";
    wait for 1 ns;
    assert (t_output = "01") report "Sub failed" severity error;
    if (t_output /= "01") then
      err_cnt := err_cnt + 1;
    end if;

    -- test 2: And
    wait for 10 ns;
    t_a <= "10";
    t_b <= "11";
    t_sel <= "10";
    wait for 1 ns;
    assert (t_output = "10") report "And failed" severity error;
    if (t_output /= "10") then
      err_cnt := err_cnt + 1;
    end if;

    -- test 2: Or
    wait for 10 ns;
    t_sel <= "11";
    wait for 1 ns;
    assert (t_output = "11") report "Or failed" severity error;
    if (t_output /= "11") then
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

configuration configure_testbench of ALU_testbench_entity is
  for testbench 
    end for;
end configure_testbench;
