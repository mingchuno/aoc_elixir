defmodule Utils.PermuteTest do
  use ExUnit.Case, async: true

  test "simple case" do
    assert Permute.permutations([1, 2]) == [[1, 2], [2, 1]]
  end

  test "single elem case" do
    assert Permute.permutations([1]) == [[1]]
  end

  test "empty case" do
    assert Permute.permutations([]) == [[]]
  end
end
