Mox.defmock(ChildComponent.DefaultImpl.MockChildStore,
  for: ChildComponent.DefaultImpl.ChildStore
)

Application.put_env(
  :child_component,
  :child_store,
  ChildComponent.DefaultImpl.MockChildStore
)

ExUnit.start()
