require_relative '../automated_init'

context "Fetch" do
  context "Entity" do
    stream_name = Controls::Write.batch

    id = stream_name.partition('-').last
    category_name = stream_name.split('-').first

    store = Controls::EntityStore.example(category: category_name)

    entity = store.fetch(id)

    test "Entity is returned" do
      assert(entity == Controls::Entity.example)
    end
  end
end
