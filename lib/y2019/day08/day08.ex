import AocFile
import Enum

defmodule Y2019.Day08.Day08 do
  def part_1(input_file) do
    target_layer =
      parse_inputs(input_file)
      |> min_by(fn xs -> count(xs, &(&1 == 0)) end)

    no_of_1 = target_layer |> count(&(&1 == 1))
    no_of_2 = target_layer |> count(&(&1 == 2))
    no_of_1 * no_of_2
  end

  def part_2(input_file) do
    parse_inputs(input_file)
    |> merge_layers
    |> print
  end

  def merge_layers(layers) do
    reduce(layers, fn lower, upper -> zip_with(lower, upper, fn l, u -> merge_pixel(u, l) end) end)
  end

  defp merge_pixel(upper, lower) do
    case {upper, lower} do
      {2, l} -> l
      {u, _} -> u
    end
  end

  defp print(image) do
    image |> chunk_every(25) |> each(&print_line/1)
  end

  defp print_line(line) do
    map(line, fn char ->
      case char do
        1 -> IO.write(".")
        0 -> IO.write(" ")
      end
    end)

    IO.write("\n")
  end

  defp parse_inputs(input_file) do
    read_input_file(input_file)
    |> List.first()
    |> String.to_charlist()
    |> map(&(&1 - 48))
    |> Enum.chunk_every(25 * 6)
  end
end
