module EntityStore
  module Postgres
    module Controls
      module Write
        def self.batch(category: nil)
          stream_name = Controls::StreamName.example(category: category)

          writer = ::Messaging::Postgres::Write.build

          batch = Batch.example

          writer.write(batch, stream_name)

          stream_name
        end
      end
    end
  end
end
