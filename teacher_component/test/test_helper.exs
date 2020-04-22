Mox.defmock(TeacherComponent.DefaultImpl.MockTeacherStore,
  for: TeacherComponent.DefaultImpl.TeacherStore
)

Application.put_env(
  :teacher_component,
  :teacher_store,
  TeacherComponent.DefaultImpl.MockTeacherStore
)

ExUnit.start()
