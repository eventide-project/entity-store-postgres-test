module EntityStore
  module Postgres
    module Controls
      ID = EntityStore::Controls::ID

      module ID
        module Random
          def self.example
            Identifier::UUID::Controls::Random.example
          end
        end
      end
    end
  end
end
