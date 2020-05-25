defmodule ClassComponent.DefaultImpl do
	@behaviour ClassComponent.Impl

	alias __MODULE__.ClassStore
	alias CrmCore.Class

	@impl true
	def find_class(class_id) do
		case ClassStore.find(class_id) do
			{:ok, %Class{} = class} ->
			{:ok, class}
			{:error, :not_found} ->
				{:error, :not_found}
		end
	end
end
