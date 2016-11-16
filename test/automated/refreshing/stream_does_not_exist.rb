require_relative '../automated_init'

context "Refreshing" do
  context "Stream Does Not Exist" do
    id = Controls::ID.example
    nonexisting_category = SecureRandom.hex

    store = Controls::EntityStore.example(category: nonexisting_category)
    SubstAttr::Substitute.(:cache, store)

    entity, version = store.get(id, include: :version)

    test "Entity is nil" do
      assert(entity == nil)
    end

    test "Version indicates no stream exists" do
      assert(version == EntityCache::Record::NoStream.version)
    end

    test "Entity is not cached" do
      refute store.cache do
        put?
      end
    end
  end
end
