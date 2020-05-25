defmodule ClassComponent.Impl do
	alias CrmCore.{Class}

	@type class_id ::Class.id()
  @callback find_class(class_id) :: {:ok, Class.t()} | {:error, :not_found}
end
