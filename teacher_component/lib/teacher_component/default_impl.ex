defmodule TeacherComponent.DefaultImpl do
	@behaviour TeacherComponent.Impl

	alias __MODULE__.TeacherStore
	alias CrmCore.Teacher

	@impl true
	def find_teacher(teacher_id) do
		case TeacherStore.find(teacher_id) do
			{:ok, %Teacher{} = teacher} ->
				{:ok, teacher}
			{:error, :not_found} ->
				{:error, :not_found}
		end
	end
end
