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

  s.add_dependency('rails', '~> 3.2.11')
  s.add_dependency('refinerycms', '~> 2.0.8')
  s.add_dependency('jquery-rails', '~> 2.0.0')
  s.add_dependency("mongoid", '>= 3.1.0')
  s.add_dependency("bson_ext")
  s.add_dependency("carrierwave")
  s.add_dependency("rmagick")
  s.add_dependency("fog")
  s.add_dependency("uuidtools")
  s.add_dependency("jquery-fileupload-rails")
  s.add_dependency('kaminari')

  s.add_development_dependency("rb-inotify", '~> 0.9')
  s.add_development_dependency("capybara")
  s.add_development_dependency("capybara-webkit")
  s.add_development_dependency("headless")
  s.add_development_dependency("database_cleaner")
  s.add_development_dependency("factory_girl")
  s.add_development_dependency("pg")
  s.add_development_dependency("rspec")
  s.add_development_dependency("rspec-rails")
  s.add_development_dependency("spork", '~> 0.9.0.rc')
  s.add_development_dependency("guard")
  s.add_development_dependency("guard-spork")
  s.add_development_dependency("guard-rspec")
  s.add_development_dependency("generator_spec")
  s.add_development_dependency('selenium-webdriver', '~> 2.25.0')
  s.add_development_dependency("fuubar")
  s.add_development_dependency("rb-readline")
  s.add_development_dependency("debugger")
  s.add_development_dependency("unicorn")
  s.add_development_dependency("konacha")
  s.add_development_dependency("guard-konacha")
end
