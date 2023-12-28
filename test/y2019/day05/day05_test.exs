alias Y2019.Day05.Day05

defmodule Y2019.Day05.Day05Test do
  use ExUnit.Case, async: true

  test "part 1" do
    assert Day05.part_1("./inputs/2019/day5-real.txt") == 5_182_797
  end

  test "part 2" do
    assert Day05.part_2("./inputs/2019/day5-real.txt") == 12_077_198
  end
end
