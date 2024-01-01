alias Y2019.Day07.Day07

defmodule Y2019.Day07.Day07Test do
  use ExUnit.Case, async: true

  test "part 1 example" do
    assert Day07.part_1("./inputs/2019/day7-example1.txt") == 43_210
  end

  test "part 1 real" do
    assert Day07.part_1("./inputs/2019/day7-real.txt") == 67_023
  end

  test "part 2" do
    assert Day07.part_2("./inputs/2019/day7-real.txt") == 7_818_398
  end

  test "part 2 example" do
    assert Day07.part_2("./inputs/2019/day7-example2.txt") == 139_629_729
  end
end
