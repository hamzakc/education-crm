defmodule Mix.Tasks.ChildComponent.Setup do
  use Mix.Task

  @shortdoc "Creates an Mnesia DB on disk for Child Component"

  @moduledoc """
  Creates an Mnesia DB on disk for Child Component

  ```
  config :mnesia, dir: 'mnesia/\#{Mix.env}/\#{node()}'
  # Notice the single quotes
  ```

  ## Production

  For production environments and compiled releases where `Mix` is not
  available, you should use `Que.Persistence.Mnesia.setup!/0` instead.
  You can [read about it here](Que.Persistence.Mnesia.html#setup!/0-on-production).


  ## Custom Node Name and Cookie

  If you need to specify the node name and cookie for the task, you can
  call it like this:

  ```bash
  $ elixir --name <node_name> --cookie <cookie> -S mix que.setup
  ```

  Source: [`elixir-lang-talk`](https://groups.google.com/forum/#!topic/elixir-lang-talk/nHPKnDF6Bl0)

  """

  @doc false
  def run(_) do
    ChildComponent.DefaultImpl.ChildStore.Mnesia.setup!()
  end
end
