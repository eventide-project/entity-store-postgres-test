require_relative 'automated_init'

context "Substitute" do
  id = Controls::ID.example

  context "Get" do
    context "Entity has not been added" do
      store = SubstAttr::Substitute.build(Controls::EntityStore.example_class)
      entity, version = store.get(id, include: :version)

      test "Entity is nil" do
        assert(entity == nil)
      end

      test "Version indicates no stream exists" do
        assert(version == EntityCache::Record::NoStream.version)
      end
    end

    context "Entity has been added" do
      control_entity = Controls::Entity.example
      control_version = Controls::Version.example

      store = SubstAttr::Substitute.build(Controls::EntityStore.example_class)
      store.add(id, control_entity, control_version)

      entity, version = store.get(id, include: :version)

      test "Entity is returned" do
        assert(entity == control_entity)
      end

      test "Version is returned" do
        assert(version == control_version)
      end
    end

    context "Version" do
      entity = Object.new
      control_version = Controls::Version.example

      store = SubstAttr::Substitute.build(Controls::EntityStore.example_class)
      store.add(id, entity, control_version)

      version = store.get_version id

      test "Version is returned" do
        assert(version == control_version)
      end
    end
  end

  context "Fetch" do
    context "Entity has not been added" do
      store = SubstAttr::Substitute.build(Controls::EntityStore.example_class)

      entity = store.fetch(id)

      test "New entity is returned" do
        refute(entity.nil?)
      end

      test "Entity's class it the store's entity class" do
        assert(entity.class == store.entity_class)
      end
    end
  end
end
