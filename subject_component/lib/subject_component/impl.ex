defmodule SubjectComponent.Impl do
  alias CrmCore.{Subject}

  @type subject_id :: Subject.id()
  @callback subject(subject_id) :: {:ok, Subject.t()} | {:error, :not_found}
end
