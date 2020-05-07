defmodule Crm.Impl do
  @moduledoc false

  alias Crm.DefaultImpl
	alias CrmCore.{Teacher, Lesson}

	@type teacher_id ::Teacher.id()

  @callback teacher(teacher_id) :: {:ok, Teacher.t()} | {:error, :not_found}
  @callback lessons(teacher_id) :: {:ok, [Lesson.t()]} | {:error, :not_found}

  def current_impl do
    Application.get_env(:crm, :impl, DefaultImpl)
  end
end
