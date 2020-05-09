defmodule ChildComponent do
  @moduledoc """
  Documentation for `ChildComponent`.
  """

  @behaviour __MODULE__.Impl

	def children(teacher_id) do
    current_impl().children(teacher_id)
	end

  @doc false
  defp current_impl do
    Application.get_env(:child_component, :impl, __MODULE__.DefaultImpl)
  end
end
