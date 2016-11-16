require_relative '../automated_init'

context "Refreshing" do
  context "Entity is Cached" do
    stream_name = Controls::Write.batch(category: 'testRefreshingEntityCached')

    id = Messaging::StreamName.get_id stream_name
    category_name = Messaging::StreamName.get_category stream_name

    store = Controls::EntityStore.example(category: category_name)
    SubstAttr::Substitute.(:cache, store)

    Controls::Entity::Cached.add(id, store)

    entity = store.get(id)

    test "Second event is projected" do
      assert entity.sum == Controls::Entity::Current.sum
    end

    context "Cache update" do
      control_id = id

      test "Entity" do
        control_entity = Controls::Entity::Current.example

        assert store.cache do
          put? do |record|
            record.id == control_id && record.entity == control_entity
          end
        end
      end

      test "Version is refreshed" do
        control_version = Controls::Version::Current.example

        assert store.cache do
          put? do |record|
            record.id == control_id && record.version == control_version
          end
        end
      end

      test "Persisted version is set to previous persisted cache version" do
        control_persisted_version = Controls::Version::Cached.example

        assert store.cache do
          put? do |record|
            record.id == control_id &&
              record.persisted_version == control_persisted_version
          end
        end
      end
    end
  end
end
