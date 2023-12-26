defmodule Y2019.Day01.Day01 do
  @spec part_1(binary()) :: number()
  def part_1(input_file) do
    AocFile.read_input_file(input_file)
    |> Stream.map(&String.to_integer(&1))
    |> Stream.map(&mass_to_fuel/1)
    |> Enum.sum()
  end

  @spec part_2(binary()) :: number()
  def part_2(input_file) do
    AocFile.read_input_file(input_file)
    |> Stream.map(&String.to_integer(&1))
    |> Stream.map(&calculate_fuel/1)
    |> Enum.sum()
  end

  defp mass_to_fuel(mass) do
    div(mass, 3) - 2
  end

  defp calculate_fuel(mass) do
    case mass_to_fuel(mass) do
      x when x >= 0 -> x + calculate_fuel(x)
      _ -> 0
    end
  end
end
