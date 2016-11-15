require_relative './bench_init'

context "Entity snapshots" do
  context "No snapshot implementation is specified" do
    store = EventStore::EntityStore::Controls::Store.example snapshot_class: nil

    test "Persistent store is not used" do
      assert store.cache.persistent_store.instance_of?(EntityCache::Storage::Persistent::None)
    end
  end

  context "Snapshot implementation is specified" do
    snapshot_class = EventStore::EntityStore::Controls::Snapshot::Example
    store = EventStore::EntityStore::Controls::Store.example snapshot_class: snapshot_class

    test "Snapshot class is built and used as persistent store" do
      assert store.cache.persistent_store.instance_of?(snapshot_class)
    end
  end
end
