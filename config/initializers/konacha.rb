Konacha.configure do |config|
  require 'capybara/poltergeist'
  config.spec_dir = "../../spec/javascripts" # path from dummy app's dir
  config.spec_matcher = /_spec\./
  config.driver = :poltergeist
  config.stylesheets = %w(application)
end if defined?(Konacha)
