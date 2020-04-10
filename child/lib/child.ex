defmodule Child do
	defdelegate get(teacher, lesson), to: Child.Loader
end
