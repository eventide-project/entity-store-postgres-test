require_relative '../automated_init'

context "Get" do
  context "Includes" do
    stream_name = Controls::Write.batch(category: 'testEntityStoreGet')

    id = Messaging::StreamName.get_id stream_name
    category_name = Messaging::StreamName.get_category stream_name

    store = Controls::EntityStore.example(category: category_name)

    test "Entity" do
      retrieved_entity, _ = store.get id, include: :id
      assert(!retrieved_entity.nil?)
    end

    context "Individual Includes" do
      test "ID" do
        _, id = store.get id, include: :id
        assert(!id.nil?)
      end

      test "Version" do
        _, version = store.get id, include: :version
        assert(!version.nil?)
      end

      test "Time" do
        _, time = store.get id, include: :time
        assert(!time.nil?)
      end
    end

    context "Permutation of Includes" do
      includes = [:time, :version, :id]

      [1, 2, 3].each do |n|
        context "Permutations of #{n}" do
          permutations = includes.permutation(n).to_a

          permutations.each do |includes|
            context "#{includes.join(', ')}" do
              results = store.get id, include: includes

              includes.each_with_index do |include, i|
                test "#{include}" do
                  refute(results[i + 1].nil?)
                end
              end
            end
          end
        end
      end
    end
  end
end
