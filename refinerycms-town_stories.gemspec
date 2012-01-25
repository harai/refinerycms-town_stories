Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-town_stories'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Town Stories engine for Refinery CMS'
  s.date              = '2012-01-06'
  s.summary           = 'Town Stories engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*']

  s.add_dependency("mongoid", ["~> 2.2"])
  s.add_dependency("refinerycms", ["~> 1.0.9"])

  s.add_development_dependency("rspec", ["~> 2.6"])
end
