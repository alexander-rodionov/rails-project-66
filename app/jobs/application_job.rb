# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception',
                  request: nil,
                  user: nil,
                  params: nil)
  rescue StandardError => e
    Rails.logger.warn "Rollbar exception #{e}"
  end

  def notify_start(check)
    CheckMailer.started(check).deliver_later
  rescue StandardError => e
    register_rollbar_error(e)
  end

  def notify_finish(check)
    CheckMailer.finished(check).deliver_later
  rescue StandardError => e
    register_rollbar_error(e)
  end
end
