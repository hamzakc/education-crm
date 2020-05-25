Mox.defmock(ClassComponent.DefaultImpl.MockClassStore,
  for: ClassComponent.DefaultImpl.ClassStore
)

Application.put_env(
  :class_component,
  :class_store,
  ClassComponent.DefaultImpl.MockClassStore
)

ExUnit.start()
