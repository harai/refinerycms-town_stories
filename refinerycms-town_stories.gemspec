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
  s.add_dependency("carrierwave", ["~> 0.5"])
  s.add_dependency("rmagick")
  s.add_dependency("fog", ["~> 1.3.1"])
  s.add_dependency("uuidtools", ["~> 2.1.2"])
  

  s.add_development_dependency("rspec")
end
