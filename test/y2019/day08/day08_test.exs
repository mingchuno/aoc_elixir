alias Y2019.Day08.Day08

defmodule Y2019.Day08.Day08Test do
  use ExUnit.Case, async: true

  test "part 1" do
    assert Day08.part_1("./inputs/2019/day8-real.txt") == 2440
  end

  test "part 2" do
    assert Day08.part_2("./inputs/2019/day8-real.txt") == :ok
  end

  test "merge layers" do
    inputs = [[0, 2, 2, 2], [1, 1, 2, 2], [2, 2, 1, 2], [0, 0, 0, 0]]
    expected = [0, 1, 1, 0]
    assert Day08.merge_layers(inputs) == expected
  end
end
