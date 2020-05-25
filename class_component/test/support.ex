## Namespace all test related modules under ClassComponent.Test.Meta
## ======================================================

defmodule ClassComponent.Test.Meta do
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
      Memento.Table.delete(ClassComponent.DefaultImpl.ClassStore.Mnesia.DB.Classes)
      Memento.Table.create(ClassComponent.DefaultImpl.ClassStore.Mnesia.DB.Classes)
      :ok
    end

    # Deletes the Mnesia DB from disk and creates a fresh one in memory
    def reset! do
      Helpers.capture_log(fn ->
        Memento.stop()
        File.rm_rf!(ClassComponent.DefaultImpl.ClassStore.Mnesia.__config__()[:path])
        Memento.start()

        reset()
      end)
    end

    # Creates sample Mnesia jobs
    def create_sample_classes do
			Memento.transaction! fn ->
				[
					Memento.Query.write(%ClassComponent.DefaultImpl.ClassStore.Mnesia.DB.Classes{
          id: 1,
					lesson_id: 1,
					teacher_id: 1,
					overview: 'Overview',
					date: '01/01/2020',
}),
					Memento.Query.write(%ClassComponent.DefaultImpl.ClassStore.Mnesia.DB.Classes{
          id: 2,
					lesson_id: 2,
					teacher_id: 2,
					overview: 'Overview',
					date: '01/01/2020',

}),
					Memento.Query.write(%ClassComponent.DefaultImpl.ClassStore.Mnesia.DB.Classes{
          id: 3,
					lesson_id: 3,
					teacher_id: 3,
					overview: 'Overview',
					date: '01/01/2020',

})
				]
			end
    end
  end
end
