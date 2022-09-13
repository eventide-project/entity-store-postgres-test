module EntityStore
  module Postgres
    module Controls
      module Write
        def self.batch(inst=nil, instances: nil, category: nil, id: nil, ids: nil, batch: nil)
          instances ||= inst
          instances ||= 2

          id ||= (ids || Controls::ID::Random.example)
          # id ||= Controls::ID::Random.example

          stream_name = Controls::StreamName.example(category: category, id: id)
          batch ||= Batch.example(instances)

          write = ::Messaging::Postgres::Write.build

          write.(batch, stream_name)

          stream_name
        end
      end
    end
  end
end
