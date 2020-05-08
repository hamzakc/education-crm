## Namespace all test related modules under LessonComponent.Test.Meta
## ======================================================

defmodule LessonComponent.Test.Meta do
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
      Application.start(:lesson_component)
    end

    def stop do
      Helpers.capture_log(fn ->
        Application.stop(:lesson_component)
      end)
    end
  end

  # Mnesia-specific helpers
  # =======================

  defmodule Helpers.Mnesia do
    # Cleans up Mnesia DB
    def reset do
      Memento.Table.delete(LessonComponent.DefaultImpl.LessonStore.Mnesia.DB.Lessons)
      Memento.Table.create(LessonComponent.DefaultImpl.LessonStore.Mnesia.DB.Lessons)
      :ok
    end

    # Deletes the Mnesia DB from disk and creates a fresh one in memory
    def reset! do
      Helpers.capture_log(fn ->
        Memento.stop()
        File.rm_rf!(LessonComponent.DefaultImpl.LessonStore.Mnesia.__config__()[:path])
        Memento.start()

        reset()
      end)
    end

    # Creates sample Mnesia jobs
    def create_sample_lessons do
			Memento.transaction! fn ->
				[
					Memento.Query.write(%LessonComponent.DefaultImpl.LessonStore.Mnesia.DB.Lessons{
          id: 1,
					teacher_id: 1,
					code: 'maths-1A',
					date: '01/01/2020',
					start_time: '1000',
					end_time: '1200',
					overview: 'Maths Lesson for students',
					title: 'Maths 1A'
        }),
					Memento.Query.write(%LessonComponent.DefaultImpl.LessonStore.Mnesia.DB.Lessons{
          id: 2,
					teacher_id: 2,
					code: 'maths-2A',
					date: '01/01/2020',
					start_time: '1000',
					end_time: '1200',
					overview: 'Maths Lesson for students',
					title: 'Maths 2A'
        }),
					Memento.Query.write(%LessonComponent.DefaultImpl.LessonStore.Mnesia.DB.Lessons{
          id: 3,
					teacher_id: 3,
					code: 'maths-3A',
					date: '01/01/2020',
					start_time: '1000',
					end_time: '1200',
					overview: 'Maths Lesson for students',
					title: 'Maths 3A'
        }),
				]
			end
    end
  end
end
