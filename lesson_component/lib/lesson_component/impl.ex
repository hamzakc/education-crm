defmodule LessonComponent.Impl do
	alias CrmCore.{Teacher, Lesson}

	@type teacher_id ::Teacher.id()
  @callback lessons(teacher_id) :: {:ok, [Lesson.t()]} | {:error, :not_found}
end
