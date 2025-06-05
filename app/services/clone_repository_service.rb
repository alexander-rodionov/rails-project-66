# frozen_string_literal: true

class CloneRepositoryService < BaseCustomService
  include NotificationConcern
  attr_reader :check

  def initialize(check_id)
    super
    @check_id = check_id
    @check = Repository::Check.find(@check_id)
  end

  def perform
    status_start_clone
    notify_clone_started

    unless @check
      status_start_failure
      return false
    end

    git_service = GitService.new(@check.repository.user)
    repo_id = @check.repository.github_id
    @check.commit_id ||= git_service.last_commit(repo_id)[:id]
    unless StorageManagementService.repo_directory_alive?(repo_id, @check.commit_id)
      StorageManagementService.acquire_directory(repo_id, @check.commit_id)
      git_service.clone(repo_id, @check.commit_id)
    end

    status_end_clone
  end

  def set_fallback_status
    status_finished
  end

  def status_start_clone
    @check.start_clone
    @check.save!
  end

  def status_end_clone
    @check.end_clone
    @check.save!
  end

  def status_failed(exception)
    @check.fail
    @check.error = exception
    @check.save!
  end

  def status_finished
    @check.end_processing
    @check.passed = true
    @check.save!
  end
end
