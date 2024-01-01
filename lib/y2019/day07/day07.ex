import AocFile
import Enum
alias Y2019.Computer.Computer

defmodule Y2019.Day07.Day07 do
  def part_1(input_file) do
    program = read_input_file(input_file) |> Computer.parse()

    Permute.permutations([0, 1, 2, 3, 4])
    |> map(fn phase_settings -> run_amplifiers(program, phase_settings) end)
    |> max()
  end

  def part_2(input_file) do
    program = read_input_file(input_file) |> Computer.parse()

    Permute.permutations([5, 6, 7, 8, 9])
    |> map(fn phase_settings -> run_amplifiers_2(program, phase_settings) end)
    |> max()
  end

  defp run_amplifiers(program, phase_settings) do
    reduce(phase_settings, 0, fn phase, output ->
      outputs = Computer.compute(program, [phase, output])
      hd(outputs)
    end)
  end

  defp run_amplifiers_2(program, phase_settings) do
    size = length(program)

    init_state =
      map(phase_settings, fn phase ->
        Computer.run_program(Computer.to_program_map(program, size), 0, [phase], [])
      end)

    hd(loop_amplifiers(init_state, size))
  end

  defp loop_amplifiers(program_last_state, size) do
    case List.last(program_last_state) do
      {:halt, outputs} ->
        outputs

      {:pending, _, _, outputs} ->
        next_input =
          case outputs do
            # initial input
            [] -> [0]
            # input from last amplifer
            [out | _] -> [out]
          end

        next_state =
          scan(program_last_state, {:pending, nil, nil, next_input}, fn x, acc ->
            pass_next_amplifier(x, acc)
          end)

        loop_amplifiers(next_state, size)
    end
  end

  defp pass_next_amplifier(x, acc) do
    next_inputs =
      case acc do
        {:pending, _, _, acc_outputs} -> hd(acc_outputs)
        {:halt, acc_outputs} -> hd(acc_outputs)
      end

    case x do
      {:pending, x_program, x_i, x_outputs} ->
        Computer.run_program(x_program, x_i, [next_inputs], x_outputs)
    end
  end
end
