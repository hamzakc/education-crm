## Namespace all test related modules under ChildComponent.Test.Meta
## ======================================================

defmodule SubjectComponent.Test.Meta do
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
      Memento.Table.delete(SubjectComponent.DefaultImpl.SubjectStore.Mnesia.DB.Subjects)
      Memento.Table.create(SubjectComponent.DefaultImpl.SubjectStore.Mnesia.DB.Subjects)
      :ok
    end

    # Deletes the Mnesia DB from disk and creates a fresh one in memory
    def reset! do
      Helpers.capture_log(fn ->
        Memento.stop()
        File.rm_rf!(SubjectComponent.DefaultImpl.SubjectStore.Mnesia.__config__()[:path])
        Memento.start()

        reset()
      end)
    end

    # Creates sample Mnesia jobs
    def create_sample_subjects do
			Memento.transaction! fn ->
				[
					Memento.Query.write(%SubjectComponent.DefaultImpl.SubjectStore.Mnesia.DB.Subjects{
          id: 1,
					code: "Boys-Maths-Year-8",
					title: "Maths Year 8 for boys",
					description: "Maths for year 8 kids Boys",
}),
					Memento.Query.write(%SubjectComponent.DefaultImpl.SubjectStore.Mnesia.DB.Subjects{
          id: 2,
					code: "Girls-Maths-Year-8",
					title: "Maths Year 8 for girls",
					description: "Maths for year 8 kids girls",
}),
					Memento.Query.write(%SubjectComponent.DefaultImpl.SubjectStore.Mnesia.DB.Subjects{
          id: 3,
					code: "Boys-Art-Year-7",
					title: "Art Year 7 for boys",
					description: "Art for year 7 kids Boys",
}),
				]
			end
    end
  end
end
