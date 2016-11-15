require_relative '../bench_init'

context "Refreshing non existent entity" do
  id = Controls::ID.get

  store = EventStore::EntityStore::Controls::Store.example
  SubstAttr::Substitute.(:cache, store)

  entity, version = store.get id, include: :version

  test "Entity is nil" do
    assert entity == nil
  end

  test "Version indicates no stream exists" do
    assert version == EntityCache::Record::NoStream.version
  end

  test "Entity is not cached" do
    refute store.cache do
      put?
    end
  end
end
