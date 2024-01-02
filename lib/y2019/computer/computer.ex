import Enum

defmodule Y2019.Computer.Computer do
  @spec compute([integer()], [integer()]) :: [integer()]
  def compute(program, input) do
    size = length(program)

    case run_program(to_program_map(program, size), 0, input, []) do
      {:halt, outputs} -> outputs
      {:pending, _, _, outputs} -> outputs
    end
  end

  @spec test_program(binary(), [integer()]) :: program_state()
  def test_program(program_str, input) do
    program =
      program_str
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)

    size = length(program)
    run_program(to_program_map(program, size), 0, input, [], 0)
  end

  @type program() :: %{integer() => integer()}

  @type program_state() ::
          {:halt, [integer()]} | {:pending, program(), non_neg_integer(), [integer()]}

  @spec run_program(
          program(),
          non_neg_integer(),
          [integer()],
          [integer()],
          integer()
        ) ::
          program_state()
  def run_program(program, i, inputs, outputs, relative_base \\ 0) when is_map(program) do
    instruction = parse_instruction(program[i] || 0)
    {op, p_mode} = instruction

    get_param = fn j ->
      case at(p_mode, j) do
        0 -> program[program[i + 1 + j] || 0] || 0
        1 -> program[i + 1 + j] || 0
        2 -> program[relative_base + (program[i + 1 + j] || 0)] || 0
      end
    end

    get_output_address = fn j ->
      case at(p_mode, j) do
        2 -> relative_base + (program[i + 1 + j] || 0)
        0 -> program[i + 1 + j]
      end
    end

    case op do
      1 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        new_program = Map.put(program, get_output_address.(2), param_0 + param_1)
        run_program(new_program, i + 4, inputs, outputs, relative_base)

      2 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        new_program = Map.put(program, get_output_address.(2), param_0 * param_1)
        run_program(new_program, i + 4, inputs, outputs, relative_base)

      3 ->
        if empty?(inputs) do
          {:pending, program, i, outputs}
        else
          [input | tail] = inputs
          param_0 = get_output_address.(0)
          new_program = Map.put(program, param_0, input)
          run_program(new_program, i + 2, tail, outputs, relative_base)
        end

      4 ->
        param_0 = get_param.(0)
        new_out = [param_0 | outputs]
        run_program(program, i + 2, inputs, new_out, relative_base)

      5 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        next_pointer = if param_0 == 0, do: i + 3, else: param_1
        run_program(program, next_pointer, inputs, outputs, relative_base)

      6 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        next_pointer = if param_0 != 0, do: i + 3, else: param_1
        run_program(program, next_pointer, inputs, outputs, relative_base)

      7 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        store = if param_0 < param_1, do: 1, else: 0
        new_program = Map.put(program, get_output_address.(2), store)
        run_program(new_program, i + 4, inputs, outputs, relative_base)

      8 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        store = if param_0 == param_1, do: 1, else: 0
        new_program = Map.put(program, get_output_address.(2), store)
        run_program(new_program, i + 4, inputs, outputs, relative_base)

      9 ->
        param_0 = get_param.(0)
        new_rb = relative_base + param_0
        run_program(program, i + 2, inputs, outputs, new_rb)

      99 ->
        {:halt, outputs}
    end
  end

  defp parse_instruction(i) do
    {op, p_mode} =
      case i do
        i when i < 100 ->
          {i, []}

        _ ->
          instruction = i |> Integer.to_string() |> String.split("", trim: true) |> reverse()
          [op1, op2 | tail] = instruction
          op = [op2, op1] |> join("") |> String.to_integer()
          p_mode = tail |> map(&String.to_integer/1)
          {op, p_mode}
      end

    padded_p_mode = p_mode ++ List.duplicate(0, instruction_size(op) - length(p_mode))
    {op, padded_p_mode}
  end

  defp instruction_size(op) do
    case op do
      1 -> 3
      2 -> 3
      3 -> 1
      4 -> 1
      5 -> 2
      6 -> 2
      7 -> 3
      8 -> 3
      9 -> 1
      99 -> 0
    end
  end

  @spec to_program_map([integer()], integer()) :: program()
  def to_program_map(program, size) do
    0..(size - 1) |> Stream.zip(program) |> into(%{})
  end

  @spec parse([binary()]) :: [integer()]
  def parse(inputs) do
    inputs
    |> List.first()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
