# -*- encoding: utf-8 -*-
Gem::Specification.new do |s|
  s.name = 'entity_store-postgres'
  s.version = '0.0.0.0'
  s.summary = 'Store of entities that are projected from streams stored in Postgres'
  s.description = ' '

  s.authors = ['The Eventide Project']
  s.email = 'opensource@eventide-project.org'
  s.homepage = 'https://github.com/eventide-project/entity-store-postgres'
  s.licenses = ['MIT']

  s.require_paths = ['lib']
  s.files = Dir.glob('{lib}/**/*')
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.2.3'

  s.add_runtime_dependency 'entity_store'

  s.add_development_dependency 'test_bench'
end
