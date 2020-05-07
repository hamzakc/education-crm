defmodule LessonComponent.DefaultImpl do
	@behaviour LessonComponent.Impl

	alias __MODULE__.LessonStore
	alias CrmCore.{Teacher, Lesson}

	@impl true
	def lessons(teacher_id) do
		case LessonStore.lessons(teacher_id) do
			{[%Lesson{}] = lessons} ->
				{:ok, [lessons]}
			[] ->
				{:error, :not_found}
		end
	end
end
