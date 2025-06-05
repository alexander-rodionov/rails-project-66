# frozen_string_literal: true

class CleanUpRepoJob < ApplicationJob
  queue_as :default

  def perform
    StorageManagementService.clean_up_directories(complete: false)
  rescue StandardError => e
    logger.error "CleanUpRepoJob failed\n #{e}"
    register_rollbar_error(e)
  end
end
