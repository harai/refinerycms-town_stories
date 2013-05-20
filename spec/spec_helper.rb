require 'rbconfig'
require 'factory_girl'

def setup_environment
  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../dummy/config/environment', __FILE__)
  require 'rspec/rails'
  require 'capybara/rails'
  require 'capybara/rspec'
  require 'capybara-screenshot/rspec'
  require 'database_cleaner'

  require 'capybara/poltergeist'

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  # Dir[File.expand_path('../support/**/*.rb', __FILE__)].each {|f| require f}
  # FactoryGirl.definition_file_paths << 'spec/support/factories'
  FactoryGirl.definition_file_paths << 'spec/support/factories'
  

  RSpec.configure do |config|
    config.mock_with :rspec

    config.fixture_path = ::Rails.root.join('spec', 'fixtures').to_s

    # Runs tests which have :focus only
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run focus: true
    config.run_all_when_everything_filtered = true

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, comment the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = false
    config.use_instantiated_fixtures  = false

    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with :truncation

    config.before :each do
      DatabaseCleaner.start
    end

    config.after :each do
      DatabaseCleaner.clean
    end

    config.include Warden::Test::Helpers, type: :feature
    config.before :all, type: :feature do
      Warden.test_mode!
    end
    config.after :all, type: :feature do
      Warden.test_reset!
    end
    Capybara.javascript_driver = :poltergeist
  end
end

def each_run
  FactoryGirl.reload
end

require 'rubygems'
# If spork is available in the Gemfile it'll be used but we don't force it.
unless (begin; require 'spork'; rescue LoadError; nil end).nil?

  Spork.prefork do
    # Loading more in this block will cause your tests to run faster. However,
    # if you change any configuration or code from libraries loaded here, you'll
    # need to restart spork for it take effect.
    setup_environment
  end

  Spork.each_run do
    # This code will be run each time you run your specs.
    each_run
  end

  # --- Instructions ---
  # - Sort through your spec_helper file. Place as much environment loading
  #   code that you don't normally modify during development in the
  #   Spork.prefork block.
  # - Place the rest under Spork.each_run block
  # - Any code that is left outside of the blocks will be ran during preforking
  #   and during each_run!
  # - These instructions should self-destruct in 10 seconds.  If they don't,
  #   feel free to delete them.
  #
else
  setup_environment
  each_run
end

def capture_stdout(stdin_str = '')
  begin
    require 'stringio'
    $o_stdin, $o_stdout, $o_stderr = $stdin, $stdout, $stderr
    $stdin, $stdout, $stderr = StringIO.new(stdin_str), StringIO.new, StringIO.new
    yield
    {:stdout => $stdout.string, :stderr => $stderr.string}
  ensure
    $stdin, $stdout, $stderr = $o_stdin, $o_stdout, $o_stderr
  end
end
