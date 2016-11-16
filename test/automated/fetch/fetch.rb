require_relative '../automated_init'

context "Fetch" do
  context "Fetch entity from store for a stream that exists" do
    stream_name = Controls::Write.batch(category: 'testFetch')

    id = Messaging::StreamName.get_id stream_name
    category_name = Messaging::StreamName.get_category stream_name

    store = Controls::EntityStore.example(category: category_name)

    entity = store.fetch(id)

    test "Entity is returned" do
      assert(entity == Controls::Entity.example)
    end
  end
end
