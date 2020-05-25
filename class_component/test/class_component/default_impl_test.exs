defmodule ClassComponent.DefaultImplTest do
  use ExUnit.Case, async: true
	import Mox

	alias ClassComponent.DefaultImpl.MockClassStore

  doctest ClassComponent

  setup [:set_mox_from_context, :verify_on_exit!]

  test "find_class/1 when class does not exist" do
		expected_result = { :error, :not_found }
		class_id = 1

		expect(MockClassStore, :find, fn ^class_id ->
			expected_result
    end)

		assert {:error, :not_found} = ClassComponent.find_class(1)
  end

	test "find_class/1 when class exists" do
		id = 1
		lesson_id = 1
		teacher_id = 1
		date = '01/01/2020'
		overview = 'Overview'

		class = %CrmCore.Class{
			id: id,
			lesson_id: lesson_id,
			teacher_id: teacher_id,
			date: date,
			overview: overview,
		}

		expect(MockClassStore, :find, fn _id ->
			{:ok, class}
    end)

		assert { :ok, class } = ClassComponent.find_class(1)
  end
end
