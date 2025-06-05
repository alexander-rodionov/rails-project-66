# frozen_string_literal: true

module NotificationConcern
  def notify_clone_started
    CheckMailer.started(@check).deliver_later
  rescue StandardError => e
    logger.error 'CheckMailer finished failed'
    register_rollbar_error(e)
  end

  def notify_processing_finished
    CheckMailer.finished(@check).deliver_later
  rescue StandardError => e
    logger.error 'CheckMailer finished failed'
    register_rollbar_error(e)
  end
end
