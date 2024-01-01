import AocFile
alias Y2019.Computer.Computer

defmodule Y2019.Day05.Day05 do
  def part_1(input_file) do
    program = read_input_file(input_file) |> Computer.parse()
    output = Computer.compute(program, [1])
    [diagnostic_code | _tail] = output
    diagnostic_code
  end

  def part_2(input_file) do
    program = read_input_file(input_file) |> Computer.parse()
    output = Computer.compute(program, [5])
    hd(output)
  end
end
