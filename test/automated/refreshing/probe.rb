require_relative '../automated_init'

context "Refreshing" do
  context "Entity is Cached" do
    stream_name = Controls::Write.batch(category: 'testRefreshingEntityCached')

    id = Messaging::StreamName.get_id stream_name
    category_name = Messaging::StreamName.get_category stream_name

    store = Controls::EntityStore.example(category: category_name)
    SubstAttr::Substitute.(:cache, store)

    Controls::Entity::Cached.add(id, store)

    events = []
    entity = store.get(id) do |event_data|
      events << event_data
    end

    test "Unprojected events are projected" do
      assert(events.last.data == Controls::Message.second.attributes)
    end
  end
end
