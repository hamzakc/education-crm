defmodule TeacherComponent.DefaultImpl.TeacherStore.Mnesia.DB do
  @moduledoc false

  # Memento Table Definition
  # ========================

  defmodule Teachers do
    use Memento.Table,
      attributes: [:id, :email, :first_name, :last_name, :tel, :position, :created_at, :updated_at],
      index: [:email],
      type: :ordered_set,
      autoincrement: true

    @moduledoc false
    @store     __MODULE__

    # Persistence Implementation
    # --------------------------

    @doc "Finds a Teacher in the DB"
    def find_teacher(teacher_id) do
      Memento.transaction! fn ->
        teacher_id
        |> normalize_id
        |> read
        |> to_teacher_component_teacher
      end
    end

    ## PRIVATE METHODS

    # Returns teacher ID
    defp normalize_id(teacher) do
      cond do
        is_map(teacher) -> teacher.id
        true        -> teacher
      end
    end

    # Convert Mnesia DB Teacher to CrmCore.Teacher
    defp to_teacher_component_teacher(nil), do: {:error, :not_found}
    defp to_teacher_component_teacher(%@store{} = teacher) do
      {:ok, struct(CrmCore.Teacher, Map.from_struct(teacher))}
    end

    # Read to Table
    defp read(id),      do: Memento.Query.read(@store, id)
  end
end
