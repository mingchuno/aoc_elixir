import AocFile
import Enum
alias Y2019.Computer.Computer

defmodule Y2019.Day07.Day07 do
  def part_1(input_file) do
    program = read_input_file(input_file) |> parse()

    Permute.permutations([0, 1, 2, 3, 4])
    |> Enum.map(fn phase_settings -> run_amplifiers(program, phase_settings) end)
    |> Enum.max()
  end

  def part_2(input_file) do
    program = read_input_file(input_file) |> parse()

    Permute.permutations([5, 6, 7, 8, 9])
    |> Enum.map(fn phase_settings -> run_amplifiers(program, phase_settings) end)
    |> Enum.max()
  end

  defp run_amplifiers(program, phase_settings) do
    Enum.reduce(phase_settings, 0, fn phase, output ->
      outputs = Computer.compute(program, [phase, output])
      hd(outputs)
    end)
  end

  defp parse(inputs) do
    inputs
    |> List.first()
    |> String.split(",")
    |> map(&String.to_integer/1)
  end
end
