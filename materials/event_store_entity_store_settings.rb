module EventStore
  module EntityStore
    class Settings < Settings
      def self.data_source
        if File.exist? path
          path
        else
          {}
        end
      end

      def self.path
        'settings/entity_store.json'
      end

      def self.instance
        @instance ||= build
      end

      def self.get(attr_name)
        instance.get attr_name
      end
    end
  end
end
