defmodule ClassComponent.DefaultImpl.ClassStore do
	alias CrmCore.Class

	@callback find(class_id :: integer) :: Class.t | nil
	def find(class_id) do
		impl().find(class_id)
	end

	def impl() do
    Application.get_env(:class_component, :class_store, __MODULE__.Mnesia)
  end

	# Macro so future adapters `use` this module
  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
