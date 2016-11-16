require_relative '../automated_init'

context "Fetch" do
  context "Stream Does Not Exist" do
    store = Controls::EntityStore.example

    store.define_singleton_method :new_entity do
      :new_entity
    end

    some_id = SecureRandom.hex
    entity = store.fetch some_id

    test "The store's new entity is returned" do
      assert(entity == :new_entity)
    end
  end
end
