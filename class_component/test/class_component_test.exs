defmodule ClassComponentTest do
  use ExUnit.Case
  doctest ClassComponent

  test "greets the world" do
    assert ClassComponent.hello() == :world
  end
end
