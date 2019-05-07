require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module AwesomeAnswers
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # This tells Rails' ActiveJob to use the gem "delayed_job"
    # to manage our job queue which will use a table in our
    # database
    config.active_job.queue_adapter = :delayed_job
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Don't generate system test files.
    config.generators.system_tests = nil

    config.generators do |g|
      g.helper = false
      g.assets = false
    end

    config.middleware.insert_before(0, Rack::Cors) do
      allow do
        # "origins" method specifies which domains are allowed
        # to make AJAX requests to this server.
        # "*" means all domains and should be avoided.
        origins("localhost:3030")

        resource(
          # Only routes that begin with /api/ are accessible
          # with AJAX
          "/api/*",
          # Which HTTP headers can be sent in a request.
          headers: :any,
          # Allow sharing of cookies for CORS requests
          # made to this resources
          credentials: true,
          # Which HTTP verbs are allowed in a request.
          methods: [:get, :post, :delete, :patch, :put, :option]
        )
      end
    end
  end
end
