defmodule Crm do
  @moduledoc """
	  Public API to CRM
	"""

  import __MODULE__.Impl, only: [current_impl: 0]

  @behaviour __MODULE__.Impl

	alias CrmCore.{Teacher, Subject, Class, Notice}

	def teacher_dashboard(teacher = %Teacher{id: teacher_id}) do
		%{
			teacher: teacher(teacher),
			lessons: lessons(teacher),
			notices: notices()
		}
	end

	def notices() do
		{:ok, [%Notice{id: 1, title: "Notice Title", description: "Notice description", summary: "Summary of desription"}]}
	end

	def teacher(%Teacher{id: teacher_id}) do
		current_impl().teacher(teacher_id)
	end

	def subject(subject = %Subject{id: _subject_id}) do
		current_impl().subject(subject)
	end

	# Find all lessons tought by the teacher
	def lessons(%Teacher{id: teacher_id}) do
		current_impl().lessons(teacher_id)
	end

	def children(teacher = %Teacher{id: _teacher_id}) do
		current_impl().children(teacher)
	end

	def class(%Class{id: class_id}) do
		current_impl().class(class_id)
	end
end

# 	def child(child = %Child{id: child_id}) do
# 	end

# 	def lesson(lesson = %Lesson{id: lesson_id}) do
# 	end

# 	def lessons(child = %Child{id: child_id}) do
# 	end

# 	def lessons(subject = %Subject{id: subject_id}) do
# 	end

# 	def lessons(subject = %Subject{id: subject_id}, lesson = %Lesson{id: lesson_id}) do
# 	end

# 	def children(lesson = %Lesson{}) do
# 	end

# 	def children(subject= %Subject{}) do
# 	end

# 	def children(teacher = %Teacher{}, :summary) do
# 	end

# 	def add_subject(%Subject{}, %Lesson{}) do
# 	end

# 	def add_child(%Child{}) do
# 	end

# 	def add_teacher(%Teacher{}) do
# 	end

# 	def add_lesson(%Lesson{}) do
# 	end

# 	def update_subject(subject = %Subject{id: subject_id}) do
# 	end

# 	def update_child(child = %Child{id: child_id}) do
# 	end

# 	def update_teacher(teacher = %Teacher{id: teacher_id}) do
# 	end

# 	def update_lesson(lesson = %Lesson{id: lesson_id}) do
# 	end

# 	def delete_subject(subject = %Subject{id: subject_id}) do
# 	end

# 	def delete_child(child = %Child{id: child_id}) do
# 	end

# 	def delete_teacher(teacher = %Teacher{id: teacher_id}) do
# 	end

# 	def delete_lesson(lesson = %Lesson{id: lesson_id}) do
# 	end

# 	def search(lesson = %Lesson{}, :query) do
# 	end

# 	def search(child = %Child{}, :query) do
# 	end

# 	def search(subject = %Subject{}, :query) do
# 	end

# 	def search(teacher = %Teacher{}, :query) do
# 	end

# 	def start_lesson(lesson = %Lesson{}, class = %Class{}) do
# 	end

# 	def mark_attendance(class = %Class{id: class_id}, :present) do
# 	end

# 	def add_note(lesson = %Lesson{id: lesson_id}, class = %Class{id: class_id}) do
# 	end

# 	def update_note(note = %Note{id: note_id}) do
# 	end

# 	def delete_note(note = %Note{id: note_id}) do
# 	end

# 	def notes(class = %Class{id: class_id}) do
# 	end

# 	def add_notice(notice = %Notice{}) do
# 	end

# 	def update_notice(notice = %Notice{id: notice_id}) do
# 	end

# 	def delete_notice(notice = %Notice{id: notice_id}) do
# 	end

# 	def notices() do
# 	end

# 	# Resources
# 	def add_resource(resource = %Resource{}) do
# 	end

# 	def update_resource(resource = %Resource{id: resource_id}) do
# 	end

# 	def delete_resource(resource = %Resource{id: resource_id}) do
# 	end

# 	# Attendance Records
# 	def attendance(lesson = %Lesson{id: lesson_id}, class = %Class{id: class_id}) do
# 	end
