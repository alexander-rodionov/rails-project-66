# frozen_string_literal: true

class CleanUpRepoJob < ApplicationJob
  queue_as :default

  def perform
    # TODO: Sentry
    logger.info 'CleanUpRepoJob started'
    StorageManagementService.clean_up_directories
    logger.info 'CleanUpRepoJob finished'
  rescue StandardError => e
    logger.error "CleanUpRepoJob failed\n #{e}"
    # TODO: Sentry
  end
end
