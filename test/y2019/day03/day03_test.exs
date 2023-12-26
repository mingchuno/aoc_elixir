defmodule Y2019.Day03.Day02Test do
  use ExUnit.Case

  test "part 1 example" do
    assert Y2019.Day03.Day03.part_1("./inputs/2019/day3-example.txt") == 6
  end

  test "part 1 real" do
    assert Y2019.Day03.Day03.part_1("./inputs/2019/day3-real.txt") == 731
  end
end