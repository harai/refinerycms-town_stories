# Encoding: UTF-8

Gem::Specification.new do |s|
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-town_stories'
  s.version           = '1.0'
  s.description       = 'Ruby on Rails Town Stories extension for Refinery CMS'
  s.date              = '2012-01-06'
  s.summary           = 'Town Stories extension for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir["{app,config,db,lib}/**/*"] + ["readme.md"]

  s.add_dependency('refinerycms-core', '~> 2.0.8')
  s.add_dependency("mongoid")
  s.add_dependency("bson_ext")
  s.add_dependency("carrierwave")
  s.add_dependency("rmagick")
  s.add_dependency("fog")
  s.add_dependency("uuidtools")
  s.add_dependency("jquery-fileupload-rails")
  

  s.add_development_dependency("rspec")
  s.add_development_dependency("factory_girl")
  s.add_development_dependency("capybara")
end
