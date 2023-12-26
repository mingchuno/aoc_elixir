alias Y2019.Day03.Day03

defmodule Y2019.Day03.Day03Test do
  use ExUnit.Case

  test "part 1 example" do
    assert Day03.part_1("./inputs/2019/day3-example.txt") == 6
  end

  test "part 1 real" do
    assert Day03.part_1("./inputs/2019/day3-real.txt") == 731
  end

  test "part 2 example" do
    assert Day03.part_2("./inputs/2019/day3-example.txt") == 30
  end

  test "part 2 real" do
    assert Day03.part_2("./inputs/2019/day3-real.txt") == 5672
  end
end
