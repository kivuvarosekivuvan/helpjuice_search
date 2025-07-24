require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
# require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require gems listed in Gemfile, including any gems you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HelpjuiceSearch
  class Application < Rails::Application
    # Initialize defaults for Rails 7.2
    config.load_defaults 7.2
    
    # ActiveJob adapter
    config.active_job.queue_adapter = :sidekiq

    # Autoload paths for lib directory
    config.autoload_lib(ignore: %w[assets tasks])

    # API-only configuration
    config.api_only = true

    # Custom configurations here
  end
end
