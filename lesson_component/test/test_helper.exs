Mox.defmock(LessonComponent.DefaultImpl.MockLessonStore,
  for: LessonComponent.DefaultImpl.LessonStore
)

Application.put_env(
  :lesson_component,
  :lesson_store,
  LessonComponent.DefaultImpl.MockLessonStore
)

ExUnit.start()
