defmodule CrmCoreTest do
  use ExUnit.Case
  doctest CrmCore

  test "greets the world" do
    assert CrmCore.hello() == :world
  end
end
