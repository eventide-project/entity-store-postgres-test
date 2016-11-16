require_relative 'interactive_init'

iterations = ENV.fetch('ITERATIONS') { '10' }.to_i

stream_name = Controls::Write.batch(category: 'testFetch')

id = Messaging::StreamName.get_id stream_name
category_name = Messaging::StreamName.get_category stream_name

store = Controls::EntityStore.example(category: category_name)

start_time = Time.now

iterations.times do
  store.get(id)
  store.cache.temporary_store.records.clear
end

finish_time = Time.now

puts "Iterations: #{iterations}, StartTime: #{start_time.strftime '%H:%M:%S.3%N'}, FinishTime: #{finish_time.strftime '%H:%M:%S.%3N'}"

average_time_ms = Rational (finish_time - start_time) * 1000, iterations
ips = Rational iterations, finish_time - start_time

puts "AverageTime: %.2fms, InstructionsPerSecond: %.2f " % [average_time_ms, ips]
