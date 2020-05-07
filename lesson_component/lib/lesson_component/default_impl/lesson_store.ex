defmodule LessonComponent.DefaultImpl.LessonStore do
  alias CrmCore.{Teacher, Lesson}

  @callback lessons(teacher_id :: integer) :: [Lesson.t()] | []
  def lessons(teacher_id) do
    impl().lessons(teacher_id)
  end

  def impl() do
    Application.get_env(:lesson_component, :lesson_store, __MODULE__.Mnesia)
  end

  # Macro so future adapters `use` this module
  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
