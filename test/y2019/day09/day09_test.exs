alias Y2019.Day09.Day09

defmodule Y2019.Day09.Day09Test do
  use ExUnit.Case, async: true

  test "part 1" do
    assert Day09.part_1("./inputs/2019/day9-real.txt") == 3_429_606_717
  end

  test "part 2" do
    assert Day09.part_2("./inputs/2019/day9-real.txt") == 33_679
  end
end
