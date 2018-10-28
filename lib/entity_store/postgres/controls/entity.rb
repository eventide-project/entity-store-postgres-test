module EntityStore
  module Postgres
    module Controls
      Entity = EntityStore::Controls::Entity

      module Entity
        module New
          def self.example
            Entity::Example.new
          end
        end
      end
    end
  end
end
