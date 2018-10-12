module EntityStore
  module Postgres
    module Controls
      module Batch
        def self.example(instances=nil)
          instances ||= 2

          [Message.first, Message.second].cycle.first(instances)
        end
      end
    end
  end
end
