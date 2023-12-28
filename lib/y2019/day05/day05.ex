import AocFile
import Enum

defmodule Y2019.Day05.Day05 do
  def part_1(input_file) do
    program = read_input_file(input_file) |> parse()
    size = length(program)

    output = run_program(to_map(program, size), size, 0, [1], [])
    [diagnostic_code | _tail] = output
    diagnostic_code
  end

  def part_2(input_file) do
  end

  defp run_program(_program, size, i, _inputs, outputs) when size == i, do: outputs

  defp run_program(program, size, i, inputs, outputs) when is_map(program) do
    instruction = parse_instruction(program[i])
    {op, p_mode} = instruction

    get_param = fn j ->
      if Enum.at(p_mode, j) == 0, do: program[program[i + 1 + j]], else: program[i + 1 + j]
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
        [input | tail] = inputs
        new_program = Map.put(program, program[i + 1], input)
        run_program(new_program, size, i + 2, tail, outputs)

      4 ->
        param_0 = get_param.(0)
        new_out = [param_0 | outputs]
        run_program(program, size, i + 2, inputs, new_out)

      99 ->
        outputs
    end
  end

  def parse_instruction(i) do
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
    # IO.inspect(op, label: "op")
    # IO.inspect(padded_p_mode, label: "p_mode")
    {op, padded_p_mode}
  end

  defp instruction_size(op) do
    case op do
      1 -> 3
      2 -> 3
      3 -> 1
      4 -> 1
      99 -> 0
    end
  end

  defp parse(inputs) do
    inputs
    |> List.first()
    |> String.split(",")
    |> map(&String.to_integer/1)
  end

  defp to_map(program, size) do
    0..(size - 1) |> Stream.zip(program) |> Enum.into(%{})
  end
end
