require_relative '../automated_init'

context "Snapshot" do
  context "Read Only" do
    snapshot_class = EntitySnapshot::Postgres::ReadOnly

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

      test "No new snapshot message is written" do
        assert(snapshot_messages.length == 1)
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
