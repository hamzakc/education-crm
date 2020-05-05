defmodule TeacherComponent.DefaultImplTest do
  use ExUnit.Case, async: true
	import Mox

	alias TeacherComponent.DefaultImpl.MockTeacherStore

  doctest TeacherComponent

  setup [:set_mox_from_context, :verify_on_exit!]

  test "find_teacher/1 when teacher does not exist" do
		expected_result = { :error, :not_found }
		teacher_id = 1

		expect(MockTeacherStore, :find, fn ^teacher_id ->
			expected_result
    end)

		assert {:error, :not_found} = TeacherComponent.find_teacher(1)
  end

	test "find_teacher/1 when teacher exists" do
		id = 1
		email = "test@example.com"
		first_name = "David"
		last_name = "Khan"
		tel = "01010"
		position = "teacher"
		created_at = nil
		updated_at = nil

		teacher = %CrmCore.Teacher{
			id: id,
			email: email,
			first_name: first_name,
			last_name: last_name,
			tel: tel,
			position: position,
			created_at: created_at,
			updated_at: updated_at
		}

		expect(MockTeacherStore, :find, fn _id ->
			{:ok, teacher}
    end)

		assert { :ok, teacher } = TeacherComponent.find_teacher(1)
  end
end
