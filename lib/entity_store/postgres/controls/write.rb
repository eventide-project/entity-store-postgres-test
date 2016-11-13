module EntityStore
  module Postgres
    module Controls
      module Write
        def self.write_batch
          stream_name = Controls::StreamName.get

          writer = EventStore::Messaging::Writer.build

          write_first stream_name, writer
          write_second stream_name, writer

          stream_name
        end

        def self.write_first(stream_name, writer=nil)
          message = Message.first

          write message, stream_name, writer

          stream_name
        end

        def self.write_second(stream_name, writer=nil)
          message = Message.second

          write message, stream_name, writer

          stream_name
        end

        def self.write(message, stream_name, writer=nil)
          writer ||= EventStore::Messaging::Writer.build

          writer.write message, stream_name
        end
      end
    end
  end
end
