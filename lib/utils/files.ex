defmodule AocFile do
  @spec read_input_file(binary()) :: [binary()]
  def read_input_file(input) do
    File.read!(input) |> String.split("\n")
  end
end
