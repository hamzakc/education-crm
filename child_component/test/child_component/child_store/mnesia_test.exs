defmodule ChildComponent.DefaultImpl.ChildStore.MnesiaTest do
  use ExUnit.Case

  alias ChildComponent.Test.Meta.Helpers
	alias ChildComponent.DefaultImpl.ChildStore.Mnesia

  setup do
    Helpers.Mnesia.reset
  end

  test "#setup! creates a Schema and persists the Mnesia DB to disk" do
    Helpers.Mnesia.reset!

    config  = Mnesia.__config__
    capture = Helpers.capture_io(&:mnesia.info/0)

    assert capture =~ ~r/Directory "#{config[:path]}" is NOT used/
    assert capture =~ ~r/ram_copies\s+=.+#{config[:database]}.+#{config[:table]}/s

    capture = Helpers.capture_all(fn ->
      assert :ok == Mnesia.setup!
      :mnesia.info
    end)

    assert capture =~ ~r/Directory "#{config[:path]}" is used/
    assert capture =~ ~r/disc_copies\s+=.+#{config[:database]}.+#{config[:table]}/s

    Helpers.Mnesia.reset!
  end

  test "#children_with_teacher gets a list of children associated to a teacher id" do
    [_, _, s | _] = Helpers.Mnesia.create_sample_children

    assert [struct(CrmCore.Child, Map.from_struct(s))] == Mnesia.children(3)
  end
end
