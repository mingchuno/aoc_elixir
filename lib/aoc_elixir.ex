defmodule AocElixir do
  def main(_args \\ []) do
    AocFile.read_input_file("./inputs/2019/day1-real.txt") |> IO.inspect()
    :hello
  end
end
