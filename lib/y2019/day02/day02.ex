defmodule Y2019.Day02.Day02 do
  def part_1(input_file) do
    program =
      AocFile.read_input_file(input_file)
      |> parse()
      |> to_map()
      |> Map.put(1, 12)
      |> Map.put(2, 2)

    end_idx = div(map_size(program), 4)

    run_program(program, end_idx, 0)
    |> Map.get(0)
  end

  defp run_program(program, end_idx, i) do
    n = i * 4

    if end_idx + 1 == i do
      program
    else
      case program[n] do
        1 ->
          run_program(
            Map.put(program, program[n + 3], program[program[n + 1]] + program[program[n + 2]]),
            end_idx,
            i + 1
          )

        2 ->
          run_program(
            Map.put(program, program[n + 3], program[program[n + 1]] * program[program[n + 2]]),
            end_idx,
            i + 1
          )

        99 ->
          program
      end
    end
  end

  defp parse(inputs) do
    inputs
    |> List.first()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  defp to_map(program) do
    0..(length(program) - 1) |> Stream.zip(program) |> Enum.into(%{})
  end
end
