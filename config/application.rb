# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.

Bundler.require(*Rails.groups)

module RailsProject66
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    config.active_job.queue_adapter = :async
    config.active_job.skip_after_callbacks_if_terminated = true

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.

    config.generators do |g|
      g.template_engine :slim
    end
    config.i18n.default_locale = :ru

    config.autoload_lib(ignore: %w[assets tasks])
    config.autoload_paths += Dir["#{config.root}/app/services/**/"]
    config.autoload_paths += Dir["#{config.root}/app/mailers/concerns/**/"]
    # config.autoload_paths += Dir["#{config.root}/app/mailers/concerns/**/"]

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    at_exit do
      unless Rails.env.test?
        begin
          Rails.logger.info('Performing post cleanup job')
          StorageManagementService.clean_up_directories(complete: true)
        rescue StandardError
          # for tests
        end
      end
    end
  end
end
