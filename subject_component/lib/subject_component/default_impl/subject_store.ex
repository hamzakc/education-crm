defmodule SubjectComponent.DefaultImpl.SubjectStore do
  alias CrmCore.{Subject}

  @callback subject(subject_id :: integer) :: Subject.t() | []
  def subject(subject_id) do
    impl().subject(subject_id)
  end

  def impl() do
    Application.get_env(:subject_component, :subject_store, __MODULE__.Mnesia)
  end

  # Macro so future adapters `use` this module
  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
