require_relative '../automated_init'

context "Snapshot" do
  context "Read-Write" do
    snapshot_class = EntitySnapshot::Postgres

    stream_name = Controls::Write.batch

    id = stream_name.partition('-').last
    category_name = stream_name.split('-').first

    store = Controls::EntityStore.example(
      category: category_name,
      snapshot_class: snapshot_class,
      snapshot_interval: 1
    )

    entity = store.fetch(id)

    snapshot_stream_name = "example:snapshot-#{id}"

    messages = MessageStore::Postgres::Get.(snapshot_stream_name)
pp messages

    test "Two snapshot messages are written" do
      assert(messages.count == 2)
    end
  end
end
