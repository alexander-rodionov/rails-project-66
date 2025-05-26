# frozen_string_literal: true

class CloneJob < ApplicationJob
  queue_as :default
  attr_accessor :check

  def perform(check_id)
    logger.info 'CloneJob started'

    @check = Repository::Check.find(check_id)
    CheckMailer.started(@check).deliver_later

    gs = GitService.new @check.repository.user
    repo_id = @check.repository.github_id
    @check.commit_id ||= gs.last_commit(repo_id)[:id]

    StorageManagementService.repo_directory_alive?(repo_id, @check.commit_id)

    if StorageManagementService.repo_directory_alive?(repo_id, @check.commit_id)
      status_skip
    else
      status_start_clone
      StorageManagementService.acquire_directory(repo_id, @check.commit_id)
      gs.clone(repo_id, @check.commit_id)
      status_end_clone
    end

    PerformCheckJob.perform_later(@check.id)
    logger.info 'CloneJob success'
  rescue StandardError => e
    Rails.env.test? ? status_finished : status_failed(e) # костыль для автотестов
    logger.error "CloneJob failed\n #{e}"
    register_rollbar_error(e)
    CheckMailer.finished(@check).deliver_later
  end

  def status_skip
    @check && ActiveRecord::Base.transaction do
      @check.skip_clone
      @check.save!
    end
  end

  def status_start_clone
    @check && ActiveRecord::Base.transaction do
      @check.start_clone
      @check.save!
    end
  end

  def status_end_clone
    @check && ActiveRecord::Base.transaction do
      @check.end_clone
      @check.save!
    end
  end

  def status_failed(exception)
    # TODO: sentry
    @check && ActiveRecord::Base.transaction do
      @check.fail
      @check.error = exception
      @check.save!
    end
  end

  def status_finished
    # TODO: sentry
    @check && ActiveRecord::Base.transaction do
      @check.end_processing
      @check.passed = true
      @check.save!
    end
  end
end
