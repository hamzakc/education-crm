defmodule SubjectComponent.DefaultImplTest do
  use ExUnit.Case, async: true
	import Mox

	alias SubjectComponent.DefaultImpl.MockSubjectStore
	alias CrmCore.Subject

  doctest SubjectComponent

  setup [:set_mox_from_context, :verify_on_exit!]

  test "subject/1 when subject does not exist" do
		expected_result = {:error, :not_found}
		subject_id = 1

		expect(MockSubjectStore, :subject, fn ^subject_id ->
			expected_result
    end)

		assert {:error, :not_found} = SubjectComponent.subject(subject_id)
  end

	test "subject/1 when subject exists" do
		id = 1
		code =  "Year-8-Maths-Boys"

		subject = %Subject{
			id: id,
			code: code,
		}

		expect(MockSubjectStore, :subject, fn _id ->
			subject
    end)

		assert { :ok, child } = SubjectComponent.subject(id)
  end
end
