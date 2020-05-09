defmodule SubjectComponent.DefaultImpl do
  @behaviour SubjectComponent.Impl

  alias __MODULE__.SubjectStore
  alias CrmCore.{Subject}

  @impl true
  def subject(subject_id) do
    case SubjectStore.subject(subject_id) do
      %Subject{} = subject ->
        {:ok, subject}
      {:error, _} ->
        {:error, :not_found}
    end
  end
end
