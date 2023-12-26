defmodule AocElixirTest do
  use ExUnit.Case
  doctest AocElixir

  test "greets the world" do
    assert AocElixir.start() == :world
  end
end
