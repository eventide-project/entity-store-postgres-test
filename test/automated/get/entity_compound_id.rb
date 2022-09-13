require_relative '../automated_init'

context "Get" do
  context "Entity" do
    context "Compound ID" do
      ids = [
        Controls::ID::Random.example,
        Controls::ID::Random.example
      ]

      stream_name = Controls::Write.batch(ids: ids)

      id = Messaging::StreamName.get_id(stream_name)
      category_name = Messaging::StreamName.get_category(stream_name)

      store = Controls::EntityStore.example(category: category_name)

      entity = store.get(id)

      control_entity = Controls::Entity.example

      comment "Entity: #{entity.pretty_inspect.chomp}"
      detail "Control Entity: #{control_entity.pretty_inspect.chomp}"
      detail "IDs: #{ids.inspect}"
      detail "Written Stream Name: #{stream_name.inspect}"
      detail "Written ID: #{id.inspect}"
      detail "Written Category: #{id.inspect}"

      test "Entity is returned" do
        assert(entity == control_entity)
      end
    end
  end
end
