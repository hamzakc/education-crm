defmodule Lesson.Loader do
	alias Lesson.{Lesson}

	def get(teacher = %Teacher.Teacher{}) do
		{
			:ok,
			%Lesson {
				code: 'A1',
				date: '01/01/2020',
				start_time: '1100',
				end_time: '1300',
				overview: 'This is a great lesson',
				title: 'Maths',
			},
			teacher
		}
	end
end
