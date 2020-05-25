defmodule ClassComponent do
  @moduledoc """
  Public API for ClassComponent.
  It is assumed that the caller to this API has already been authorized
  """

  @behaviour __MODULE__.Impl

  @doc """
  Get Class by ID
  """
  @impl true
  def find_class(class_id) do
    current_impl().find_class(class_id)
  end

	@doc false
	defp current_impl do
    Application.get_env(:class_component, :impl, __MODULE__.DefaultImpl)
  end
end
