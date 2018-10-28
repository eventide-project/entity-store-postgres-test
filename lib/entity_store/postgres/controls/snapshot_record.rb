## TODO Remove - Scott Bellware, Sun Oct 28

# module EntityStore
#   module Postgres
#     module Controls
#       module SnapshotRecord
#         module Write
#           def self.call(category: nil, id: nil, message_data: nil)
#             message_data ||= MessageData.example

#             stream_name = Controls::StreamName.example(category: category, id: id, type: 'snapshot')

#             write = ::MessageStore::Postgres::Write.build

#             write.(message_data, stream_name)

#             stream_name
#           end
#         end

#         module MessageData
#           def self.example(sum: nil, version: nil, time: nil)
#             sum ||= 1
#             version ||= 1
#             time ||= Controls::Time.example

#             data = {
#               entity_data: {
#                 sum: sum
#               },
#               entity_version: version,
#               time: time
#             }

#             message_data = MessageStore::MessageData::Write.build

#             message_data.data = data
#             message_data.type = 'Recorded'

#             message_data
#           end
#         end
#       end
#     end
#   end
# end
