require_relative '../bench_init'

context "Fetch returns a newly-constructed entity for stream that does not exist" do
  store = EventStore::EntityStore::Controls::Store.example

  store.define_singleton_method :new_entity do
    :new_entity
  end

  some_id = SecureRandom.hex
  entity = store.fetch some_id

  test "The store's new entity is returned" do
    assert(entity == :new_entity)
  end
end
