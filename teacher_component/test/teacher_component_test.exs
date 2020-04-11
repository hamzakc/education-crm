defmodule TeacherComponentTest do
  use ExUnit.Case
  doctest TeacherComponent

  test "greets the world" do
    assert TeacherComponent.hello() == :world
  end
end
