# frozen_string_literal: true

class CloneRepositoryJob < ApplicationJob
  queue_as :default
  attr_accessor :check

  def perform(check_id)
    clone_repository_service = CloneRepositoryService.new(check_id)
    clone_repository_service.perform
  rescue StandardError => e
    if STATUS_FALLBACK
      clone_repository_service.set_fallback_status
    else
      clone_repository_service.status_failed(e)
    end
    logger.error "CloneJob failed\n #{e}"
    register_rollbar_error(e)
    clone_repository_service.notify_processing_finished
  end
end
