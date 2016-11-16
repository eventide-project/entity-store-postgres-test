require_relative 'scripts_init'

Runner.('controls/**/*.rb') do |exclude|
  exclude =~ /(_init.rb)\z/
end
