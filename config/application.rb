# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsProject66
  class Application < Rails::Application
    # config.load_defaults 8.0
    config.load_defaults 7.2

    config.generators do |g|
      g.template_engine :slim
    end
    config.i18n.default_locale = :ru

    config.autoload_lib(ignore: %w[assets tasks])
    config.autoload_paths += Dir["#{config.root}/app/services/**/"]
    config.autoload_paths += Dir["#{config.root}/app/mailers/concerns/**/"]
    config.autoload_paths += Dir["#{config.root}/app/lib/stubs/**/"]
    # Rails.logger.debug config.autoload_paths
  end
end
