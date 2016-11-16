require_relative '../automated_init'

context "Get" do
  context "Entity" do
    stream_name = Controls::Write.batch(category: 'testEntityStoreGet')

    id = Messaging::StreamName.get_id stream_name
    category_name = Messaging::StreamName.get_category stream_name

    store = Controls::EntityStore.example(category: category_name)

    entity = store.get(id)

    test "Entity is returned" do
      assert(entity == Controls::Entity.example)
    end
  end
end
