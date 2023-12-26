alias Y2019.Day02.Day02

defmodule Y2019.Day02.Day02Test do
  use ExUnit.Case

  test "part 1" do
    assert Day02.part_1("./inputs/2019/day2-real.txt") == 3_716_293
  end

  test "part 2" do
    assert Day02.part_2("./inputs/2019/day2-real.txt") == 6429
  end
end
