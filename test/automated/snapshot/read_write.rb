require_relative '../automated_init'

context "Snapshot" do
  context "Read-Write" do
    snapshot_class = EntitySnapshot::Postgres

    category = 'example'
    id = Controls::ID::Random.example

    batch = Controls::Batch.example
    sum = batch.collect {|m| m.number }.inject(:+)

    first_number = batch.first.number
    snapshot_record = Controls::Snapshot::Write::MessageData.example(
      sum: first_number,
      version: 0
    )

    snapshot_stream_name = Controls::Snapshot::Write.(
      category: category,
      id: id,
      message_data: snapshot_record
    )

    Controls::Write.batch(category: category, id: id)

    store = Controls::EntityStore.example(
      category: category,
      snapshot_class: snapshot_class,
      snapshot_interval: 1
    )

    entity = store.fetch(id)

    context "Snapshot Records" do
      snapshot_messages = MessageStore::Postgres::Get.(snapshot_stream_name)

      test "A new snapshot message is written" do
        assert(snapshot_messages.length == 2)
      end

      context "New Snapshot Record" do
        new_record = snapshot_messages.last
        snapshot_sum = new_record.data[:entity_data][:sum]

        entity_data = entity.to_h
        snapshot_entity_data = new_record.data[:entity_data].to_h

        test "Projected entity state is recorded" do
          assert(snapshot_entity_data == entity_data)
        end

      end
    end

    context "Entity Projection" do
      last_number = batch.last.number
      snapshot_sum = snapshot_record.data[:entity_data][:sum]

      contol_sum = snapshot_sum + last_number

      test "Only messages precluded from the initial snapshot are projected" do
        assert(entity.sum == contol_sum)
      end
    end
  end
end
