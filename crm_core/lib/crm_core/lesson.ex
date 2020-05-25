# TODO: Need to accomidate multiple teachers for one lesson.
defmodule CrmCore.Lesson do
	defstruct(
		id: nil,
		teacher_id: nil,
		code: nil,
		date: nil,
		start_time: nil,
		end_time: nil,
		overview: nil,
		title: nil
	)
end
