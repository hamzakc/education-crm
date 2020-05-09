defmodule SubjectComponent do
  @moduledoc """
  Documentation for `SubjectComponent`.
  """

  @behaviour __MODULE__.Impl

	def subject(subject_id) do
		current_impl().subject(subject_id)
	end

	@doc false
	defp current_impl do
    Application.get_env(:child_component, :impl, __MODULE__.DefaultImpl)
  end
end
