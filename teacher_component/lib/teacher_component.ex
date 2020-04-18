defmodule TeacherComponent do
	@moduledoc """
	This module provides the Public API called by Teachers.
  It is assumed that the caller to this API has already been authorized
  and has full access to the data. The authorization is not a concern of this module!

  All interactions to this API require the UUID of the teacher.

  This simple API will allow for a Teacher to
	* View their profile
	* View all the lessons they are assigned to
  * View all the children they teach, with the ability to filter by lesson
  """
	alias TeacherComponent.{Lessons, Children}

	@doc """
	Retrieves all lessons for teacher given a teacher UUID
	"""
	defdelegate lessons(teacher_uuid), to: Lessons, as: :all

	@doc """
	Retrieves all children taught by a given teacher, with a optional lesson UUID
	"""
	defdelegate children(teacher_uuid, lesson_uuid \\ nil), to: Children, as: :all

	@doc """
	Get profile information for teacher UUID
	"""
	defdelegate self(teacher_uuid), to: Teachers, as: :find
end
