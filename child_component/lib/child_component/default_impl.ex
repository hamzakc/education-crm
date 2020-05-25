defmodule ChildComponent.DefaultImpl do
  @behaviour ChildComponent.Impl

  alias __MODULE__.ChildStore
  alias CrmCore.{Child}

  @impl true
  def children(teacher_id) do
    case ChildStore.children(teacher_id) do
      [%Child{}] = children ->
        {:ok, children}

      [] ->
        {:error, :not_found}
    end
  end
end
