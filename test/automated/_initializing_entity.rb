require_relative './bench_init'

context "Initializing an entity" do
  context "Factory method is defined on the entity class" do
    entity_class = Class.new do
      attr_accessor :build_called

      def self.build
        instance = new
        instance.build_called = true
        instance
      end
    end

    store = EventStore::EntityStore::Controls::Store.example entity_class: entity_class

    entity = store.new_entity

    test "Factory method is used" do
      assert entity.build_called
    end
  end

  context "No factory method is defined on the entity class" do
    entity_class = Class.new

    store = EventStore::EntityStore::Controls::Store.example entity_class: entity_class

    entity = store.new_entity

    test "Entity is instantiated" do
      assert entity.is_a?(entity_class)
    end
  end
end
