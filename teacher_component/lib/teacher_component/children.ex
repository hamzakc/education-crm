defmodule TeacherComponent.Children do
	alias TeacherComponent.{Teacher, Lesson, Child}

	# Get all children associate to the teacher and lesson
	def all(teacher = %Teacher{}, lesson = %Lesson{}) do
		{:ok,
		 mock_child(),
		 lesson,
		 teacher
		}
	end

	#Get all children associated to the teacher
	def all(teacher = %Teacher{}, lesson = nil) do
		{:ok,
		 [mock_child(), mock_child()],
		 lesson,
		 teacher
		}
	end

	defp mock_child() do
		%Child{
			first_name: 'Imran',
			last_name: 'Khan',
			date_joined: '01/01/2020',
			dob: '01/01/1989',
			year: '8'
		}
	end
end
