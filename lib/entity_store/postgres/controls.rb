require 'entity_store/controls'

require 'entity_store/postgres/controls/stream_name'
require 'entity_store/postgres/controls/version'
require 'entity_store/postgres/controls/message'
require 'entity_store/postgres/controls/entity'
require 'entity_store/postgres/controls/projection'
require 'entity_store/postgres/controls/snapshot'
require 'entity_store/postgres/controls/write'

puts Rainbow("WARNING: EntityStore control not loaded").bright.white.bg(:red)
# require 'entity_store/postgres/controls/entity_store'
