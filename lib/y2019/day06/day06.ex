import AocFile
import Enum

defmodule Y2019.Day06.Day06 do
  @spec part_1(binary()) :: number()
  def part_1(input_file) do
    tree =
      read_input_file(input_file)
      |> map(&parse_tree_line/1)
      |> reduce(%{}, &build_tree/2)

    dfs(tree, "COM", 1)
  end

  defp dfs(tree, key, distance) do
    Map.get(tree, key, []) |> sum_of(fn moon -> dfs(tree, moon, distance + 1) + distance end)
  end

  defp build_tree({from, to}, map) do
    Map.update(map, from, [to], fn existing_value -> [to | existing_value] end)
  end

  defp build_parent({from, to}, map), do: Map.put(map, to, from)

  defp sum_of(list, fun), do: map(list, fun) |> sum()

  def part_2(input_file) do
    parent_map =
      read_input_file(input_file)
      |> map(&parse_tree_line/1)
      |> reduce(%{}, &build_parent/2)

    my_parent = find_parent(parent_map, [], "YOU") |> into(MapSet.new())
    santa_parent = find_parent(parent_map, [], "SAN") |> into(MapSet.new())
    MapSet.symmetric_difference(my_parent, santa_parent) |> MapSet.size()
  end

  defp find_parent(_map, result, "COM"), do: result

  defp find_parent(map, result, key) do
    find_parent(map, [map[key] | result], map[key])
  end

  defp parse_tree_line(line) do
    [from, to] = String.split(line, ")")
    {from, to}
  end
end
