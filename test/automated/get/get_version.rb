require_relative '../automated_init'

context "Get" do
  context "Version" do
    id = Controls::ID.example

    store = Controls::EntityStore.example
    SubstAttr::Substitute.(:cache, store)

    _, control_version = Controls::Entity::Cached.add(id, store)

    version = store.get_version(id)

    test "Version is returned" do
      assert(version == control_version)
    end
  end
end
