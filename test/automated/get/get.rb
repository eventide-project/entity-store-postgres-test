require_relative '../automated_init'

context "Get entity from store" do
  stream_name = Postgres::Controls::Write.batch

  id = Messaging::StreamName.get_id stream_name
  category_name = Messaging::StreamName.get_category stream_name

  # store = EventStore::EntityStore::Controls::Store.example

  # store.category_name = category_name

  # entity = store.get id

  # test "Entity is returned" do
  #   assert entity == EventStore::EntityStore::Controls::Entity.example
  # end
end
