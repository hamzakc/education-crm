defmodule Lesson do
	defdelegate get(teacher), to: Lesson.Loader
end
