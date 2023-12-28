import AocFile
import Enum
alias Y2019.Computer.Computer

defmodule Y2019.Day05.Day05 do
  def part_1(input_file) do
    program = read_input_file(input_file) |> parse()
    output = Computer.compute(program, [1])
    [diagnostic_code | _tail] = output
    diagnostic_code
  end

  def part_2(input_file) do
    program = read_input_file(input_file) |> parse()
    output = Computer.compute(program, [5])
    hd(output)
  end

  defp parse(inputs) do
    inputs
    |> List.first()
    |> String.split(",")
    |> map(&String.to_integer/1)
  end
end
