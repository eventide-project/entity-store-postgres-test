require_relative '../automated_init'

context "Get" do
  context "Includes" do
    context "Stream Doesn't Exist" do
      store = Controls::EntityStore.example

      id = SecureRandom.hex

      test "Entity" do
        retrieved_entity, _ = store.get id, include: :id
        assert(retrieved_entity.nil?)
      end

      context "Individual Includes" do
        test "ID" do
          _, id = store.fetch id, include: :id
          assert(id.nil?)
        end

        test "Version" do
          _, version = store.fetch id, include: :version
          assert(version == :no_stream)
        end

        test "Time" do
          _, time = store.fetch id, include: :time
          assert(time.nil?)
        end
      end

      context "Permutation of Includes" do
        includes = [:time, :version, :id]

        [1, 2, 3].each do |n|
          context "Permutations of #{n}" do
            permutations = includes.permutation(n).to_a

            permutations.each do |includes|
              context "#{includes.join(', ')}" do
                results = store.fetch id, include: includes

                includes.each_with_index do |include, i|
                  test "#{include}" do
                    result = results[i + 1]

                    if include == :version
                      assert(result == :no_stream)
                    else
                      assert(result.nil?)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
