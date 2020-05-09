defmodule Mix.Tasks.SubjectComponent.Setup do
  use Mix.Task

  @shortdoc "Creates an Mnesia DB on disk for Subject Component"

  @doc false
  def run(_) do
    SubjectComponent.DefaultImpl.SubjectStore.Mnesia.setup!()
  end
end
