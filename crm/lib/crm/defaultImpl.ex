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
end
