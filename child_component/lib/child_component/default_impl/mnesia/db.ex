defmodule ChildComponent.DefaultImpl.ChildStore.Mnesia.DB do
  @moduledoc false

  # Memento Table Definition
  # ========================

  defmodule Children do
    use Memento.Table,
      attributes: [
        :id,
        :teacher_id,
				:first_name,
				:last_name,
				:date_joined,
				:dob,
				:gender,
        :created_at,
        :updated_at,
      ],
      index: [:teacher_id],
      type: :ordered_set,
      autoincrement: true

    @moduledoc false
    @store __MODULE__

    # Persistence Implementation
    # --------------------------

    @doc "Finds all children for a given teacher id"
    def children_with_teacher(teacher_id) do
      run_query({:==, :teacher_id, teacher_id})
    end

    ## PRIVATE METHODS

    # Execute a Memento Query
    defp run_query(pattern) do
      Memento.transaction!(fn ->
        @store
        |> Memento.Query.select(pattern)
        |> Enum.map(&to_child/1)
      end)
    end

    # Returns teacher ID
    defp normalize_id(lesson) do
      cond do
        is_map(lesson) -> lesson.id
        true -> lesson
      end
    end

    defp to_child(nil), do: {:error, :not_found}

    defp to_child(%@store{} = child) do
      struct(CrmCore.Child, Map.from_struct(child))
    end

    # Read to Table
    defp read(id), do: Memento.Query.read(@store, id)
  end
end
