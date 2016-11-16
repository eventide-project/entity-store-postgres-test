require_relative '../automated_init'

context "Get" do
  context "Stream does not exist" do
    id = SecureRandom.hex

    store = Controls::EntityStore.example

    entity = store.get(id)

    test "Entity is nil" do
      assert(entity.nil?)
    end
  end
end
