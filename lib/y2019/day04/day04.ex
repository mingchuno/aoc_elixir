defmodule Y2019.Day04.Day04 do
  def part_1() do
    res =
      for i <- 171_309..643_603 do
        xs =
          Integer.to_string(i)
          |> String.split("", trim: true)

        zipped = zip_with_next(xs)

        Enum.all?(zipped, fn [a, b] -> a <= b end) &&
          Enum.any?(zipped, fn [a, b] -> a == b end)
      end

    Enum.count(res, & &1)
  end

  defp zip_with_next(list), do: Enum.chunk_every(list, 2, 1, :discard)
end
