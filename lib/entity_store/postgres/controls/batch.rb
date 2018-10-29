module EntityStore
  module Postgres
    module Controls
      module Batch
        def self.example(inst=nil, instances: nil)
          instances ||= inst
          instances ||= 2

          [Message.first, Message.second].cycle.first(instances)
        end
      end
    end
  end
end
