defmodule CrmTest do
  use ExUnit.Case
  doctest Crm

  test "greets the world" do
    assert Crm.hello() == :world
  end
end
