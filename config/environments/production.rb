# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = false
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.assets.compile = false
  config.active_storage.service = :local
  config.assume_ssl = true
  config.force_ssl = true
  config.logger = ActiveSupport::Logger.new($stdout)
                                       .tap  { |logger| logger.formatter = Logger::Formatter.new }
                                       .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_tags = [:request_id]
  config.log_level = ENV.fetch('RAILS_LOG_LEVEL', 'info')
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_job.queue_adapter = :async
  config.active_job.verbose_enqueue_logs = true
  config.action_mailer.default_url_options = { host: 'example.com' }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV.fetch('MAIL_HOST', nil),
    port: ENV.fetch('MAIL_PORT', nil),
    user_name: ENV.fetch('MAIL_USER', nil),
    password: ENV.fetch('MAIL_PASSWORD', nil),
    authentication: 'plain',
    enable_starttls_auto: true
  }

  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]

  # config.assets.css_compressor = nil
  # config.assets.digest = false
end
