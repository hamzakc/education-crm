## Namespace all test related modules under ChildComponent.Test.Meta
## ======================================================

defmodule ChildComponent.Test.Meta do
  require Logger

  # Helper Module for Tests
  # =======================

  defmodule Helpers do
    # Captures IO output
    def capture_io(fun) do
      ExUnit.CaptureIO.capture_io(fun)
    end

    # Captures logged text to IO
    def capture_log(fun) do
      ExUnit.CaptureLog.capture_log(fun)
    end

    # Captures everything
    def capture_all(fun) do
      capture_io(fn ->
        IO.puts(capture_log(fn -> fun |> capture_io |> IO.puts() end))
      end)
    end
  end

  # App-specific helpers
  # ====================
  defmodule Helpers.App do
    # Restarts app and resets DB
    def reset do
			IO.puts 'I am in reset'
      stop()
      Helpers.Mnesia.reset()
      start()
      :ok
    end

    def start do
      Application.start(:child_component)
    end

    def stop do
      Helpers.capture_log(fn ->
        Application.stop(:child_component)
      end)
    end
  end

  # Mnesia-specific helpers
  # =======================

  defmodule Helpers.Mnesia do
    # Cleans up Mnesia DB
    def reset do
      Memento.Table.delete(ChildComponent.DefaultImpl.ChildStore.Mnesia.DB.Children)
      Memento.Table.create(ChildComponent.DefaultImpl.ChildStore.Mnesia.DB.Children)
      :ok
    end

    # Deletes the Mnesia DB from disk and creates a fresh one in memory
    def reset! do
      Helpers.capture_log(fn ->
        Memento.stop()
        File.rm_rf!(ChildComponent.DefaultImpl.ChildStore.Mnesia.__config__()[:path])
        Memento.start()

        reset()
      end)
    end

    # Creates sample Mnesia jobs
    def create_sample_children do
			Memento.transaction! fn ->
				[
					Memento.Query.write(%ChildComponent.DefaultImpl.ChildStore.Mnesia.DB.Children{
          id: 1,
					teacher_id: 1,
					first_name: 'David',
					last_name: 'Smith',
					date_joined: '01/01/2020',
					dob: '01/01/1997',
					gender: 'M'
}),
					Memento.Query.write(%ChildComponent.DefaultImpl.ChildStore.Mnesia.DB.Children{
          id: 2,
					teacher_id: 2,
					first_name: 'Joy',
					last_name: 'Pink',
					date_joined: '01/01/2020',
					dob: '01/01/1981',
					gender: 'F'
}),
					Memento.Query.write(%ChildComponent.DefaultImpl.ChildStore.Mnesia.DB.Children{
          id: 3,
					teacher_id: 3,
					first_name: 'Daniel',
					last_name: 'Pink',
					date_joined: '01/01/2020',
					dob: '01/01/1982',
					gender: 'M'
})
				]
			end
    end
  end
end
