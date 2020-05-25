defmodule Crm.Impl do
  @moduledoc false

  alias Crm.DefaultImpl
	alias CrmCore.{Teacher, Lesson, Child, Subject, Class}

	@type teacher_id ::Teacher.id()
	@type class_id ::Class.id()
	@type teacher ::Teacher
	@type subject ::Subject

  @callback teacher(teacher_id) :: {:ok, Teacher.t()} | {:error, :not_found}
  @callback class(class_id) :: {:ok, Class.t()} | {:error, :not_found}
  @callback lessons(teacher_id) :: {:ok, [Lesson.t()]} | {:error, :not_found}
  @callback children(teacher) :: {:ok, [Child.t()]} | {:error, :not_found}
  @callback subject(subject) :: {:ok, [Subject.t()]} | {:error, :not_found}

  def current_impl do
    Application.get_env(:crm, :impl, DefaultImpl)
  end
end
