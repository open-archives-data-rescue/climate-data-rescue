require_relative 'boot'

# require 'rails/all'
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
# require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DataRescueAtHome
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Disable asset pipeline, should all be moved to webpacker now
    # config.generators { |g| g.assets false }

    if !Rails.env.test?
      config.active_job.queue_adapter = :sidekiq
    end

    config.time_zone = "Eastern Time (US & Canada)"

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.i18n.default_locale = :en
    config.i18n.fallbacks = [:en, :fr]

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable escaping HTML in JSON.
    config.active_support.escape_html_fieldgroups_in_json = true

    #
    config.active_record.schema_format = :sql

    # base URL setting
    Rails.application.routes.default_url_options[:host] = ENV["BASE_URL"]
  end
end
