import AocFile

defmodule Y2019.Day02.Day02 do
  def part_1(input_file) do
    program = read_input_file(input_file) |> parse()
    size = length(program)
    run_with_noun_verb(program, size, 12, 2)
  end

  def part_2(input_file) do
    program = read_input_file(input_file) |> parse()
    size = length(program)

    for(
      n <- 0..99,
      v <- 0..99,
      do: {n, v}
    )
    |> Enum.find(fn {n, v} -> run_with_noun_verb(program, size, n, v) == 19_690_720 end)
    |> then(fn {n, v} -> 100 * n + v end)
  end

  defp run_with_noun_verb(corrupted_program, size, noun, verb) do
    program =
      corrupted_program
      |> to_map(size)
      |> Map.put(1, noun)
      |> Map.put(2, verb)

    end_idx = div(size, 4)

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

  defp to_map(program, size) do
    0..(size - 1) |> Stream.zip(program) |> Enum.into(%{})
  end
end
