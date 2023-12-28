alias Y2019.Day07.Day07

defmodule Y2019.Day07.Day07Test do
  use ExUnit.Case, async: true

  test "part 1 example" do
    assert Day07.part_1("./inputs/2019/day7-example1.txt") == 43210
  end

  test "part 1 real" do
    assert Day07.part_1("./inputs/2019/day7-real.txt") == 67023
  end

  # test "part 2" do
  #   assert Day07.part_2("./inputs/2019/day5-real.txt") == 12_077_198
  # end
end
