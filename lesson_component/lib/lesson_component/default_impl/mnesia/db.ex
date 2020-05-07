defmodule LessonComponent.DefaultImpl.LessonStore.Mnesia.DB do
  @moduledoc false

  # Memento Table Definition
  # ========================

  defmodule Lessons do
    use Memento.Table,
      attributes: [:id, :teacher_id, :code, :date, :start_time, :end_time, :overview, :title, :created_at, :updated_at],
      index: [:code, :teacher_id],
      type: :ordered_set,
      autoincrement: true

    @moduledoc false
    @store     __MODULE__

    # Persistence Implementation
    # --------------------------

    @doc "Finds all lessons for a given teacher id"
    def lessons_for_teacher(teacher_id) do
			run_query(
        {:==, :teacher_id, teacher_id}
      )
    end

    ## PRIVATE METHODS

		# Execute a Memento Query
    defp run_query(pattern) do
      Memento.transaction! fn ->
        @store
        |> Memento.Query.select(pattern)
        |> Enum.map(&to_lesson/1)
      end
    end

    # Returns teacher ID
    defp normalize_id(teacher) do
      cond do
        is_map(teacher) -> teacher.id
        true        -> teacher
      end
    end

    # Convert Mnesia DB Teacher to CrmCore.Lesson
    defp to_lesson(nil), do: {:error, :not_found}
    defp to_lesson(%@store{} = lesson) do
      {:ok, struct(CrmCore.Lesson, Map.from_struct(lesson))}
    end

    # Read to Table
    defp read(id),      do: Memento.Query.read(@store, id)
	end
end
