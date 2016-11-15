require_relative '../bench_init'

context "Fetch entity from store for a stream that exists" do
  stream_name = EventStore::EntityStore::Controls::Writer.write_batch

  id = EventStore::Messaging::StreamName.get_id stream_name
  category_name = EventStore::Messaging::StreamName.get_category stream_name

  store = EventStore::EntityStore::Controls::Store.example

  store.category_name = category_name

  entity = store.fetch id

  test "Entity is returned" do
    assert entity == EventStore::EntityStore::Controls::Entity.example
  end
end
