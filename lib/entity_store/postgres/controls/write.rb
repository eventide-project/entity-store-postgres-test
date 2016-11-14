module EntityStore
  module Postgres
    module Controls
      module Write
        def self.batch
          stream_name = Controls::StreamName.example

          writer = ::Messaging::Postgres::Write.build

          batch = [Message.first, Message.second]

          writer.write batch, stream_name

          stream_name
        end
      end
    end
  end
end
