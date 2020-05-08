defmodule LessonComponent.DefaultImplTest do
  use ExUnit.Case, async: true
	import Mox

	alias LessonComponent.DefaultImpl.MockLessonStore
	alias CrmCore.Lesson

  doctest LessonComponent

  setup [:set_mox_from_context, :verify_on_exit!]

  test "lessons/1 when teacher does not have any lessons" do
		expected_result = []
		teacher_id = 1

		expect(MockLessonStore, :lessons, fn ^teacher_id ->
			expected_result
    end)

		assert {:error, :not_found} = LessonComponent.lessons(teacher_id)
  end

	test "lessons/1 when teacher has associated lessons" do
		id = 1
		title = "Test Lesson"
		teacher_id = 3

		lesson = %Lesson{
			id: id,
			teacher_id: teacher_id,
			title: title
		}

		expect(MockLessonStore, :lessons, fn _id ->
			[lesson]
    end)

		assert { :ok, [lesson] } = LessonComponent.lessons(teacher_id)
  end
end
