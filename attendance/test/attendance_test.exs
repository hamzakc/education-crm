defmodule AttendanceTest do
  use ExUnit.Case
  doctest Attendance

  test "greets the world" do
    assert Attendance.hello() == :world
  end
end
