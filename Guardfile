notification :terminal_title

guard 'spork', rspec_env: { 'RAILS_ENV' => 'test' }, wait: 240 do
  watch(%r{^config/initializers/.+\.rb$})
  watch('config/routes.rb')
  watch('Gemfile')
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  watch(%r{^spec/dummy/(app|config|db)/})
end

guard 'rspec', cli: '--format Fuubar --drb' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/.+\.rb$}) { 'spec' }
  watch('spec/spec_helper.rb') { 'spec' }

  # Rails example
  watch(%r{^app/controllers/(.+)_controller\.rb$}) { |m| "spec/features/#{m[1]}_spec.rb" }
  watch(%r{^app/models/(.+)\.rb$}) { |m| "spec/models/#{m[1]}_spec.rb" }
  watch(%r{^app/uploaders/(.+)\.rb$}) { 'spec' }
  watch(%r{^app/views/(.*)/[^/]+.erb$}) { |m| "spec/features/#{m[1]}_spec.rb" }
  watch(%r{^spec/support/}) { 'spec' }
  watch('config/routes.rb') { "spec" }
  watch(%r{^lib/assets/}) { 'spec' }
end

require 'capybara/poltergeist'
guard :konacha, driver: :poltergeist, spawn_wait: 240 do
  watch(%r{^lib/assets/javascripts/(.+)\.js$}) { |m| "spec/javascripts/#{m[1]}_spec.js" }
  watch(%r{^spec/javascripts/.+_spec\.js$})
end
