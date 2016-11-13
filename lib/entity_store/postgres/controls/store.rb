module EventStore
  module EntityStore
    module Controls
      module Store
        def self.example(category: nil, entity_class: nil, projection_class: nil, snapshot_class: nil)
          if category.nil? && entity_class.nil? && projection_class.nil? && snapshot_class.nil?
            store_class = Example
          else
            store_class = example_class category, entity_class, projection_class, snapshot_class
          end

          instance = store_class.build
          instance
        end

        def self.example_class(category=nil, entity_class=nil, projection_class=nil, snapshot_class=nil)
          category ||= Controls::Store::Category.example
          entity_class ||= Controls::Entity::Example
          projection_class ||= Controls::Projection::Example

          Class.new do
            include EventStore::EntityStore

            category category
            entity entity_class
            projection projection_class

            snapshot snapshot_class unless snapshot_class.nil?
          end
        end

        module Category
          def self.example
            :some_category
          end
        end

        Example = self.example_class
      end
    end
  end
end
