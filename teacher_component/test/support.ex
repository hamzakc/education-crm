## Namespace all test related modules under TeacherComponent.Test.Meta
## ======================================================

defmodule TeacherComponent.Test.Meta do
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
      Application.start(:teacher_component)
    end

    def stop do
      Helpers.capture_log(fn ->
        Application.stop(:teacher_component)
      end)
    end
  end

  # Mnesia-specific helpers
  # =======================

  defmodule Helpers.Mnesia do
    # Cleans up Mnesia DB
    def reset do
      Memento.Table.delete(TeacherComponent.DefaultImpl.TeacherStore.Mnesia.DB.Teachers)
      Memento.Table.create(TeacherComponent.DefaultImpl.TeacherStore.Mnesia.DB.Teachers)
      :ok
    end

    # Deletes the Mnesia DB from disk and creates a fresh one in memory
    def reset! do
      Helpers.capture_log(fn ->
        Memento.stop()
        File.rm_rf!(TeacherComponent.DefaultImpl.TeacherStore.Mnesia.__config__()[:path])
        Memento.start()

        reset()
      end)
    end

    # Creates sample Mnesia jobs
    def create_sample_teachers do
			Memento.transaction! fn ->
				[
					Memento.Query.write(%TeacherComponent.DefaultImpl.TeacherStore.Mnesia.DB.Teachers{
          id: 1,
          email: "test_teacher1@example.com",
          first_name: "David",
          last_name: "Khan",
          tel: "01010 92929",
          position: "Head of Maths"
        }),
				Memento.Query.write(%TeacherComponent.DefaultImpl.TeacherStore.Mnesia.DB.Teachers{
          id: 2,
          email: "test_teacher2@example.com",
          first_name: "Jane",
          last_name: "Doe",
          tel: "01010 929292",
          position: "Head of History"
        }),
				Memento.Query.write(%TeacherComponent.DefaultImpl.TeacherStore.Mnesia.DB.Teachers{
          id: 3,
          email: "test_teacher3@example.com",
          first_name: "John",
          last_name: "Blank",
          tel: "73739 9933",
          position: "Head of PE"
})
				]
		  end
    end
  end
end
