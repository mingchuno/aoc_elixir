alias Y2019.Day05.Day05

defmodule Y2019.Day05.Day05Test do
  use ExUnit.Case, async: true

  test "part 1" do
    assert Day05.part_1("./inputs/2019/day5-real.txt") == 5_182_797
  end

  test "part 2" do
    assert Day05.part_2("./inputs/2019/day5-real.txt") == 12_077_198
  end

  test "parse_instruction 1" do
    Day05.parse_instruction(1002) == {2, [0, 1, 0]}
  end

  test "parse_instruction 2" do
    Day05.parse_instruction(3) == {3, [0]}
  end
end
