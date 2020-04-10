defmodule Child.Loader do

	def get(teacher = %Teacher.Teacher{}, lesson = %Lesson.Lesson{}) do
		{:ok,
		 %Child.Child{
			 first_name: 'Imran',
			 last_name: 'Khan',
			 date_joined: '01/01/2020',
			 dob: '01/01/1989',
			 year: '8'
		 },
		 lesson,
		 teacher
		}
	end
end
