defmodule ChildComponent.DefaultImplTest do
  use ExUnit.Case, async: true
  import Mox

  alias ChildComponent.DefaultImpl.MockChildStore
  alias CrmCore.Child

  doctest ChildComponent

  setup [:set_mox_from_context, :verify_on_exit!]

  test "children/1 when teacher does not teach any children" do
    expected_result = []
    teacher_id = 1

    expect(MockChildStore, :children, fn ^teacher_id ->
      expected_result
    end)

    assert {:error, :not_found} = ChildComponent.children(teacher_id)
  end

  test "children/1 when teacher has no associated children" do
    id = 1
    first_name = "David"
    last_name = 'Smith'
    teacher_id = 3

    child = %Child{
      id: id,
      teacher_id: teacher_id,
      first_name: first_name,
      last_name: last_name
    }

    expect(MockChildStore, :children, fn _id ->
      [child]
    end)

    assert {:ok, [child]} = ChildComponent.children(teacher_id)
  end
end
