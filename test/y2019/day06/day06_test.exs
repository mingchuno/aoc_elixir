alias Y2019.Day06.Day06

defmodule Y2019.Day06.Day06Test do
  use ExUnit.Case, async: true

  test "part 1 example" do
    assert Day06.part_1("./inputs/2019/day6-example.txt") == 42
  end

  test "part 1 real" do
    assert Day06.part_1("./inputs/2019/day6-real.txt") == 249_308
  end

  test "part 2 example" do
    assert Day06.part_2("./inputs/2019/day6-example2.txt") == 4
  end

  test "part 2 real" do
    assert Day06.part_2("./inputs/2019/day6-real.txt") == 349
  end
end
