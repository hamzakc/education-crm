defmodule TeacherComponent.Lessons do
	alias TeacherComponent.{Teacher, Lesson}

	# Get all lessons associated to the teacher
	def all(teacher = %Teacher{}) do
		{
			:ok,
			[%Lesson {
				code: 'A1',
				date: '01/01/2020',
				start_time: '1100',
				end_time: '1300',
				overview: 'This is a great lesson',
				title: 'Maths',
			}],
			teacher
		}
	end
end
