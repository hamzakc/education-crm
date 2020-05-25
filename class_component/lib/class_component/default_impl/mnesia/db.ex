defmodule ClassComponent.DefaultImpl.ClassStore.Mnesia.DB do
  @moduledoc false

  # Memento Table Definition
  # ========================

  defmodule Classes do
    use Memento.Table,
      attributes: [:id, :lesson_id, :teacher_id, :date, :overview, :created_at, :updated_at],
      index: [:lesson_id, :teacher_id],
      type: :ordered_set,
      autoincrement: true

    @moduledoc false
    @store     __MODULE__

    # Persistence Implementation
    # --------------------------

    @doc "Finds a Class in the DB"
    def find_class(class_id) do
      Memento.transaction! fn ->
        class_id
        |> normalize_id
        |> read
        |> to_class_component_class
      end
    end

    ## PRIVATE METHODS

    # Returns teacher ID
    defp normalize_id(class) do
      cond do
        is_map(class) -> class.id
        true        -> class
      end
    end

    # Convert Mnesia DB Class to CrmCore.Class
    defp to_class_component_class(nil), do: {:error, :not_found}
    defp to_class_component_class(%@store{} = class) do
      {:ok, struct(CrmCore.Class, Map.from_struct(class))}
    end

    # Read to Table
    defp read(id),      do: Memento.Query.read(@store, id)
  end
end
