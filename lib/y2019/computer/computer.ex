import Enum

defmodule Y2019.Computer.Computer do
  @spec compute(list(integer()), list(integer())) :: list(integer())
  def compute(program, input) do
    size = length(program)

    case run_program(to_program_map(program, size), size, 0, input, []) do
      {:halt, outputs} -> outputs
      {:pending, _, _, outputs} -> outputs
    end
  end

  @type program() :: %{integer() => integer()}

  @type program_state() ::
          {:halt, list(integer())} | {:pending, program(), non_neg_integer(), list(integer())}

  @spec run_program(
          program(),
          non_neg_integer(),
          non_neg_integer(),
          list(integer()),
          list(integer())
        ) ::
          program_state()
  def run_program(_program, size, i, _inputs, outputs) when size == i, do: {:halt, outputs}

  def run_program(program, size, i, inputs, outputs) when is_map(program) do
    # dbg()
    instruction = parse_instruction(program[i])
    {op, p_mode} = instruction

    get_param = fn j ->
      if at(p_mode, j) == 0, do: program[program[i + 1 + j]], else: program[i + 1 + j]
    end

    case op do
      1 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        new_program = Map.put(program, program[i + 3], param_0 + param_1)
        run_program(new_program, size, i + 4, inputs, outputs)

      2 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        new_program = Map.put(program, program[i + 3], param_0 * param_1)
        run_program(new_program, size, i + 4, inputs, outputs)

      3 ->
        if empty?(inputs) do
          {:pending, program, i, outputs}
        else
          [input | tail] = inputs
          new_program = Map.put(program, program[i + 1], input)
          run_program(new_program, size, i + 2, tail, outputs)
        end

      4 ->
        param_0 = get_param.(0)
        new_out = [param_0 | outputs]
        run_program(program, size, i + 2, inputs, new_out)

      5 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        next_pointer = if param_0 == 0, do: i + 3, else: param_1
        run_program(program, size, next_pointer, inputs, outputs)

      6 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        next_pointer = if param_0 != 0, do: i + 3, else: param_1
        run_program(program, size, next_pointer, inputs, outputs)

      7 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        store = if param_0 < param_1, do: 1, else: 0
        new_program = Map.put(program, program[i + 3], store)
        run_program(new_program, size, i + 4, inputs, outputs)

      8 ->
        param_0 = get_param.(0)
        param_1 = get_param.(1)
        store = if param_0 == param_1, do: 1, else: 0
        new_program = Map.put(program, program[i + 3], store)
        run_program(new_program, size, i + 4, inputs, outputs)

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
      99 -> 0
    end
  end

  @spec to_program_map(list(integer()), integer()) :: program()
  def to_program_map(program, size) do
    0..(size - 1) |> Stream.zip(program) |> into(%{})
  end

  @spec parse(list(binary())) :: list(integer())
  def parse(inputs) do
    inputs
    |> List.first()
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
