defmodule LessonComponent do
  @behaviour __MODULE__.Impl

	@doc """
	Get all lessons associated with a teacher id
	"""
  @impl true
  def lessons(teacher_id) do
    current_impl().lessons(teacher_id)
  end

  @doc false
  defp current_impl do
    Application.get_env(:lesson_component, :impl, __MODULE__.DefaultImpl)
  end
end
