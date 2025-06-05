# frozen_string_literal: true

class PerformCheckJob < ApplicationJob
  queue_as :default
  attr_accessor :check

  def perform(check_id)
    perform_check_status = PerformCheckService.new(check_id)
    perform_check_status.perform
  rescue StandardError => e
    if STATUS_FALLBACK
      perform_check_status.set_fallback_status
    else
      perform_check_status.status_failed(e)
    end
    Rails.logger.error "PerformCheckJob failure #{e}"
    register_rollbar_error(e)
    perform_check_status.notify_processing_finished
  end
end
