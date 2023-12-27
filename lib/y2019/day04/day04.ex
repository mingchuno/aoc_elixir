defmodule Y2019.Day04.Day04 do
  defp range(), do: 171_309..643_603

  def part_1() do
    res =
      for i <- range() do
        zipped =
          Integer.to_string(i)
          |> String.split("", trim: true)
          |> zip_with_next()

        Enum.all?(zipped, fn [a, b] -> a <= b end) &&
          Enum.any?(zipped, fn [a, b] -> a == b end)
      end

    Enum.count(res, & &1)
  end

  def part_2() do
    res =
      for i <- range() do
        strings =
          Integer.to_string(i)
          |> String.split("", trim: true)
          |> Enum.map(&String.to_integer/1)

        zipped_2 =
          strings
          |> zip_with_next()

        Enum.all?(zipped_2, fn [a, b] -> a <= b end) &&
          Enum.any?(zipped_2, fn [a, b] -> a == b end) &&
          strings |> Enum.frequencies() |> Enum.any?(fn {_, v} -> v == 2 end)
      end

    Enum.count(res, & &1)
  end

  defp zip_with_next(list), do: Enum.chunk_every(list, 2, 1, :discard)
end
