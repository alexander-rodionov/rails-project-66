# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception')
  rescue StandardError => e
    Rails.logger.warn "Rollbar exception #{e}"
  end
end
