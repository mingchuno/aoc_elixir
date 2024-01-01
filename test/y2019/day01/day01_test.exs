alias Y2019.Day01.Day01

defmodule Y2019.Day01.Day01Test do
  use ExUnit.Case

  test "part 1" do
    assert Day01.part_1("./inputs/2019/day1-real.txt") == 3_325_342
  end

  test "part 2 example" do
    assert Day01.part_2("./inputs/2019/day1-example.txt") == 50_346
  end

  test "part 2 real" do
    assert Day01.part_2("./inputs/2019/day1-real.txt") == 4_985_158
  end
end
