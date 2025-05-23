# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception',
                  request: request,
                  user: current_user,
                  params: params.to_unsafe_h)
  rescue StandardError => e
    Rails.logger.warning "Rollbar exception #{e}"
  end
end
