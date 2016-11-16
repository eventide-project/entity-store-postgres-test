module EntityStore
  module Postgres
    def self.included(cls)
      cls.class_exec do
        include Log::Dependency
        include Messaging::StreamName

        substitute_class = Class.new(Subst)

        substitute_class.send :define_method, :entity_class do
          cls.entity_class
        end

        const_set :Substitute, substitute_class

        attr_accessor :session
        attr_accessor :new_entity_probe

        dependency :cache, EntityCache

        configure :store

        extend Build
        extend EntityMacro
        extend ProjectionMacro
        extend SnapshotMacro
      end
    end

    module Build
      def build(snapshot_interval: nil, session: nil)
        instance = new
        instance.session = session

        EntityCache.configure(
          instance,
          entity_class,
          persistent_store: snapshot_class,
          persist_interval: snapshot_interval
        )

        instance
      end
    end

    def get(id, include: nil)
      logger.trace { "Getting entity (ID: #{id.inspect}, Entity Class: #{entity_class.name}, Include: #{include.inspect})" }

      record = cache.get id

      if record
        entity = record.entity
        version = record.version
        persisted_version = record.persisted_version
        persisted_time = record.persisted_time
      else
        entity = new_entity
      end

      current_version = refresh entity, id, version

      unless current_version.nil?
        record = cache.put(
          id,
          entity,
          current_version,
          persisted_version,
          persisted_time
        )
      end

      logger.info { "Get entity done (ID: #{id.inspect}, Entity Class: #{entity_class.name}, Include: #{include.inspect}, Version: #{record&.version.inspect}, Time: #{record&.time.inspect})" }
      logger.info(tags: [:data, :entity]) { entity.pretty_inspect }

      if record
        record.destructure include
      else
        EntityCache::Record::NoStream.destructure include
      end
    end

    def refresh(entity, id, current_position)
      logger.trace { "Refreshing (ID: #{id.inspect}, Entity Class: #{entity_class.name}, Current Position #{current_position.inspect})" }
      logger.trace(tags: [:data, :entity]) { entity.pretty_inspect }

      stream_name = self.stream_name(id)

      start_position = next_position(current_position)

      project = projection_class.build(entity)

      logger.trace { "Reading (Stream Name: #{stream_name}, Position: #{current_position}" }
      EventSource::Postgres::Read.(stream_name, position: start_position, session: session) do |event_data|
        project.(event_data)
        current_position = event_data.position
      end
      logger.debug { "Read (Stream Name: #{stream_name}, Position: #{current_position}" }

      logger.debug { "Refreshed (ID: #{id.inspect}, Entity Class: #{entity_class.name}, Current Position: #{current_position.inspect})" }
      logger.debug(tags: [:data, :entity]) { entity.pretty_inspect }

      current_position
    end

    def next_position(position)
      unless position.nil?
        position + 1
      else
        nil
      end
    end

    def get_version(id)
      _, version = get id, include: :version
      version
    end

    def fetch(id, include: nil)
      res = get(id, include: include)

      if res.nil?
        res = new_entity
      end

      if res.is_a?(Array) && res[0].nil?
        res[0] = new_entity
      end

      res
    end

    def new_entity
      entity = nil
      if entity_class.respond_to? :build
        entity = entity_class.build
      else
        entity = entity_class.new
      end

      unless new_entity_probe.nil?
        new_entity_probe.(entity)
      end

      entity
    end

    module EntityMacro
      def entity_macro(cls)
        define_singleton_method :entity_class do
          cls
        end

        define_method :entity_class do
          self.class.entity_class
        end
      end
      alias_method :entity, :entity_macro
    end

    module ProjectionMacro
      def projection_macro(cls)
        define_method :projection_class do
          cls
        end
      end
      alias_method :projection, :projection_macro
    end

    module SnapshotMacro
      def self.extended(cls)
        cls.singleton_class.virtual :snapshot_class
      end

      def snapshot_macro(cls)
        define_singleton_method :snapshot_class do
          cls
        end
      end

      alias_method :snapshot, :snapshot_macro
    end
  end
end
