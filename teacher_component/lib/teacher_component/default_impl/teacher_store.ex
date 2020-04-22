defmodule TeacherComponent.DefaultImpl.TeacherStore do
	alias TeacherComponent.Teacher

	@callback find(teacher_id :: integer) :: Teacher.t | nil
	def find(teacher_id) do
		impl().find(teacher_id)
	end

	def impl() do
    Application.get_env(:teacher_component, :teacher_store, __MODULE__.Mensia)
  end

	# Macro so future adapters `use` this module
  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
