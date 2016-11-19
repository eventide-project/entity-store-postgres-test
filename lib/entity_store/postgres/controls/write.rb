module EntityStore
  module Postgres
    module Controls
      module Write
        def self.batch(category: nil, partition: nil)
          stream_name = Controls::StreamName.example(category: category)

          writer = ::Messaging::Postgres::Write.build

          batch = [Message.first, Message.second]

          writer.write(batch, stream_name, partition: nil)

          stream_name
        end
      end
    end
  end
end
