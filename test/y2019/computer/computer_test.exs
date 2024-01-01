alias Y2019.Computer.Computer

defmodule Y2019.Computer.ComputerTest do
  use ExUnit.Case

  test "opcode 9" do
    program = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"

    assert Computer.test_program(program, []) ==
             {:halt, [99, 0, 101, 1006, 101, 16, 100, 1008, 100, 1, 100, 1001, -1, 204, 1, 109]}
  end

  test "large number handling" do
    program = "1102,34915192,34915192,7,4,7,99,0"
    assert Computer.test_program(program, [1]) == {:halt, [1_219_070_632_396_864]}
  end

  test "large number handling 2" do
    program = "104,1125899906842624,99"
    assert Computer.test_program(program, [1]) == {:halt, [1_125_899_906_842_624]}
  end
end
