defmodule ChildComponent.Impl do
  alias CrmCore.{Teacher, Child}

  @type teacher_id :: Teacher.id()
  @callback children(teacher_id) :: {:ok, [Child.t()]} | {:error, :not_found}
end
