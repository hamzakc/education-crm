defmodule NoteTest do
  use ExUnit.Case
  doctest Note

  test "greets the world" do
    assert Note.hello() == :world
  end
end
