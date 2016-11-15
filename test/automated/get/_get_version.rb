require_relative '../bench_init'

context "Get the version of a stream, ignoring the entity" do
  id = Controls::ID.get

  store = EventStore::EntityStore::Controls::Store.example
  SubstAttr::Substitute.(:cache, store)

  _, control_version = EventStore::EntityStore::Controls::Entity::Cached.add store, id

  version = store.get_version id

  test "Version is returned" do
    assert version == control_version
  end
end
