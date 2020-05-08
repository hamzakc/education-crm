defmodule LessonComponent.DefaultImpl.LessonStore.MnesiaTest do
  use ExUnit.Case

  alias LessonComponent.Test.Meta.Helpers
	alias LessonComponent.DefaultImpl.LessonStore.Mnesia

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

  test "#lessons gets a list of lessons associated to a teacher id" do
    [_, _, s | _] = Helpers.Mnesia.create_sample_lessons

    assert [struct(CrmCore.Lesson, Map.from_struct(s))] == Mnesia.lessons(3)
  end
end
