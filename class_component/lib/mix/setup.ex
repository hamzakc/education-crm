defmodule Mix.Tasks.ClassComponent.Setup do
  use Mix.Task

  @shortdoc "Creates an Mnesia DB on disk for Class Component"

  @doc false
  def run(_) do
    ClassComponent.DefaultImpl.ClassStore.Mnesia.setup!()
  end
end
