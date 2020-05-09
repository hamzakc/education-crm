Mox.defmock(SubjectComponent.DefaultImpl.MockSubjectStore,
  for: SubjectComponent.DefaultImpl.SubjectStore
)

Application.put_env(
  :subject_component,
  :subject_store,
  SubjectComponent.DefaultImpl.MockSubjectStore
)

ExUnit.start()
