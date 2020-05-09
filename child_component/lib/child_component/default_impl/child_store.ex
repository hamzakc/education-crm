defmodule ChildComponent.DefaultImpl.ChildStore do
  alias CrmCore.{Child}

  @callback children(teacher_id :: integer) :: [Child.t()] | []
  def children(teacher_id) do
    impl().children(teacher_id)
  end

  def impl() do
    Application.get_env(:child_component, :child_store, __MODULE__.Mnesia)
  end

  # Macro so future adapters `use` this module
  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
