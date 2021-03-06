defmodule TeacherComponent.Impl do
	alias CrmCore.{Teacher}

	@type teacher_id ::Teacher.id()
  @callback find_teacher(teacher_id) :: {:ok, Teacher.t()} | {:error, :not_found}
end
