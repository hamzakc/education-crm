defmodule TeacherComponent do
	alias TeacherComponent.{Auth, Lessons, Children}

	defdelegate load(email, password), to: Auth # Move Auth to own component
	defdelegate lessons(teacher), to: Lessons, as: :all
	defdelegate children(teacher, lesson \\ nil), to: Children, as: :all
end
