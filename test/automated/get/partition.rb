require_relative '../automated_init'

context "Get" do
  context "Entity" do
    context "Partition" do
      partition = Controls::Partition.example
      stream_name = Controls::Write.batch(category: 'testEntityStoreGetPartition', partition: partition)

      id = Messaging::StreamName.get_id stream_name
      category_name = Messaging::StreamName.get_category stream_name

      store = Controls::EntityStore.example(category: category_name, partition: partition)

      entity = store.get(id)

      test "Entity is returned" do
        assert(entity == Controls::Entity.example)
      end
    end
  end
end
