Konacha.configure do |config|
  require 'capybara-webkit'
  require 'headless'
  headless = Headless.new
  headless.start
  at_exit do
    headless.destroy
  end
  config.spec_dir = "../../spec/javascripts" # path from dummy app's dir
  config.spec_matcher = /_spec\./
  config.driver = :webkit
  config.stylesheets = %w(application)
end if defined?(Konacha)
