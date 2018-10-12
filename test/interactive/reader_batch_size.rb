ENV['LOG_TAGS'] ||= '_untagged,message_store,-data'
ENV['LOG_LEVEL'] ||= 'debug'

require_relative './interactive_init'

batch_size = 2

category = Controls::Category.example

store = Controls::EntityStore.example(category: category, reader_batch_size: batch_size)

stream_name = Controls::Write.batch(batch_size + 1, category: category)

id = Messaging::StreamName.get_id(stream_name)

entity = store.get(id)

pp entity
