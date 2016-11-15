require_relative '../bench_init'

context "Get entity from store for stream that does not exist" do
  id = SecureRandom.hex

  store = EventStore::EntityStore::Controls::Store.example

  entity = store.get id

  test "Entity is nil" do
    assert(entity.nil?)
  end
end
