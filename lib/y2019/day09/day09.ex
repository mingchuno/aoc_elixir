import AocFile
alias Y2019.Computer.Computer

defmodule Y2019.Day09.Day09 do
  def part_1(input_file) do
    read_input_file(input_file) |> Computer.parse() |> Computer.compute([1]) |> hd
  end

  def part_2(input_file) do
    read_input_file(input_file) |> Computer.parse() |> Computer.compute([2]) |> hd
  end
end
