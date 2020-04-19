defmodule TeacherComponent.DefaultImpl.TeacherStore do
	alias TeacherComponent.Teacher

  @adapter __MODULE__.Mensia

	@callback find(teacher_id :: integer) :: Teacher.t | nil
	defdelegate find(teacher_id), to: @adapter

	# Macro so future adapters `use` this module
	# Stolen from https://github.com/sheharyarn/que/blob/master/lib/que/persistence/persistence.ex#L154
  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
