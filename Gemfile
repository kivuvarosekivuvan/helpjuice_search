# Gemfile
source 'https://rubygems.org'

ruby '3.2.2'

# Rails framework (API-only)
gem 'rails', '~> 7.0'

# Database adapter
gem 'pg', '>= 0.18', '< 2.0'

# Web server
gem 'puma', '~> 6.4'

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end


# Background jobs
gem 'redis', '~> 4.0'
gem 'sidekiq'

# Cross-origin resource sharing
gem 'rack-cors'

# Boot performance
gem 'bootsnap', '>= 1.4.4', require: false

# Windows zoneinfo data
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  # Testing framework
gem 'rspec-rails', '~> 6.0'
  # Debugging tools
gem 'debug', platforms: %i[mri windows], require: 'debug/prelude'
  # Security linting
gem 'brakeman', require: false
  # Ruby style linting
gem 'rubocop-rails-omakase', require: false
end