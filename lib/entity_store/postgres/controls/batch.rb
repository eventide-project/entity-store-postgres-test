module EntityStore
  module Postgres
    module Controls
      module Batch
        def self.example
          [Message.first, Message.second]
        end
      end
    end
  end
end
