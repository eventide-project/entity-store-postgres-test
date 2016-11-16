require_relative '../automated_init'

context "New Entity" do
  context "Probe" do
    store = Controls::EntityStore.example

    probed_entity = nil
    store.new_entity_probe = proc { |entity| probed_entity = entity }

    new_entity = store.new_entity

    test "Probe action is executed" do
      assert(new_entity == probed_entity)
    end
  end
end
