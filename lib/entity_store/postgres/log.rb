module EntityStore
  module Postgres
    class Log < ::Log
      def tag!(tags)
        tags << :entity_store_postgres
        tags << :library
        tags << :verbose
      end
    end
  end
end
