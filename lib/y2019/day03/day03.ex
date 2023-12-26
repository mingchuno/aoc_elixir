defmodule Y2019.Day03.Day03 do
  def part_1(input_file) do
    AocFile.read_input_file(input_file)
    |> Enum.map(&parse_line/1)
    |> Enum.map(&walk_line/1)
    |> Enum.reduce(&MapSet.intersection/2)
    |> Enum.map(fn {x, y} -> abs(x) + abs(y) end)
    |> Enum.filter(&(&1 != 0))
    |> Enum.min()
  end

  defp walk_line(steps) do
    {_, set} = Enum.reduce(steps, {{0, 0}, MapSet.new()}, &walk_step/2)
    set
  end

  defp walk_step({direction, steps}, {{x, y}, set}) do
    {x_end, y_end} =
      case direction do
        :up -> {x, y - steps}
        :down -> {x, y + steps}
        :left -> {x - steps, y}
        :right -> {x + steps, y}
      end

    new_set =
      for(i <- x..x_end, j <- y..y_end, do: {i, j})
      |> Enum.reduce(set, &MapSet.put(&2, &1))

    {{x_end, y_end}, new_set}
  end

  defp parse_line(path) do
    path |> String.split(",") |> Enum.map(&parse_step/1)
  end

  defp parse_step(step) do
    count = step |> String.slice(1..-1) |> String.to_integer()

    case String.first(step) do
      "U" -> {:up, count}
      "D" -> {:down, count}
      "R" -> {:right, count}
      "L" -> {:left, count}
    end
  end
end
