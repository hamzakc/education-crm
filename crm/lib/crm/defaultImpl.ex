defmodule Crm.DefaultImpl do
	@behaviour __MODULE__.Impl

	@impl true
	def teacher(teacher_id) do
    with {:ok, teacher} <- TeacherComponent.find_teacher(teacher_id)
			do
			  {:ok, teacher}
			else
				err -> err
		end
	end

	@impl true
	def lessons(teacher_id) do
    with {:ok, [lesson]} <- LessonComponent.lessons(teacher_id)
			do
			  {:ok, [lesson]}
			else
				err -> err
		end
	end

	@impl true
	def children(teacher) do
    with {:ok, [child]} <- ChildComponent.children(teacher.id)
			do
			  {:ok, [child]}
			else
				err -> err
		end
	end
end
