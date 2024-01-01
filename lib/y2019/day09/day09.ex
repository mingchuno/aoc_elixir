import AocFile
alias Y2019.Computer.Computer

defmodule Y2019.Day09.Day09 do
  def part_1(input_file) do
    program = read_input_file(input_file) |> Computer.parse()

    hd(Computer.compute(program, [1]) |> IO.inspect())
  end

  def part_2(input_file) do
  end
end
