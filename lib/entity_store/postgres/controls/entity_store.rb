module EntityStore
  module Postgres
    module Controls
      module EntityStore
        def self.example(category: nil, entity_class: nil, projection_class: nil, snapshot_class: nil, snapshot_interval: nil, reader_batch_size: nil)
          reader_class = MessageStore::Postgres::Read
          ::EntityStore::Controls::EntityStore.example(category: category, entity_class: entity_class, projection_class: projection_class, reader_class: reader_class, snapshot_class: snapshot_class, snapshot_interval: snapshot_interval, reader_batch_size: reader_batch_size)
        end
      end
    end
  end
end
