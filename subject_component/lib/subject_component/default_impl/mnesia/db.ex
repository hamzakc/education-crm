defmodule SubjectComponent.DefaultImpl.SubjectStore.Mnesia.DB do
  @moduledoc false

  # Memento Table Definition
  # ========================

  defmodule Subjects do
    use Memento.Table,
      attributes: [:id, :code, :title, :description, :created_at, :updated_at],
      index: [:code],
      type: :ordered_set,
      autoincrement: true

    @moduledoc false
    @store     __MODULE__

    # Persistence Implementation
    # --------------------------

    @doc "Finds a Subject in the DB"
    def find_subject(subject_id) do
      Memento.transaction! fn ->
        subject_id
        |> normalize_id
        |> read
        |> to_subject
      end
    end

    ## PRIVATE METHODS

    # Returns teacher ID
    defp normalize_id(subject) do
      cond do
        is_map(subject) -> subject.id
        true        -> subject
      end
    end

    # Convert Mnesia DB Teacher to CrmCore.Teacher
    defp to_subject(nil), do: {:error, :not_found}
    defp to_subject(%@store{} = subject) do
      struct(CrmCore.Subject, Map.from_struct(subject))
    end

    # Read to Table
    defp read(id), do: Memento.Query.read(@store, id)
  end
end
