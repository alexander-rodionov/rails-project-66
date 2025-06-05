# frozen_string_literal: true

class PerformCheckService < BaseCustomService
  include NotificationConcern
  attr_reader :check

  def initialize(check_id)
    super
    @check_id = check_id
    @check = Repository::Check.find(@check_id)
  end

  def perform
    status_start_processing

    git_service = Github::Client.new(@check.repository.user)

    Rollbar.info(summary(@check, git_service))

    check_list = BaseCheckService.checks_factory(
      git_service.repo_languages(@check.repository.github_id)
    )
    if check_list.empty?
      status_no_checks
      notify_processing_finished
      return false
    end

    unless StorageManagementService.repo_directory_alive?(@check.repository.github_id, @check.commit_id)
      status_created
      return
    end

    clone_dir = StorageManagementService.dir_name(@check.repository.github_id, @check.commit_id)

    @check.result = check_list.to_h do |c|
      check_result = c.new(clone_dir).check
      [c.language, { success: check_result[0], result: check_result[1] }]
    end

    status_end_processing
    notify_processing_finished
  end

  def set_fallback_status
    status_finished
  end

  def status_created
    @check.recreate
    @check.save!
  end

  def status_no_checks
    @check.no_checks
    @check.save!
  end

  def status_start_processing
    @check.start_processing
    @check.save!
  end

  def status_end_processing
    @check.end_processing
    @check.passed = @check.passed?
    @check.save!
  end

  def status_failed(exception)
    @check.fail
    @check.error = exception
    @check.save!
  end

  def summary(check, git_service)
    JSON.pretty_generate(
      {
        time: 3.hours.from_now.strftime('%d/%m/%Y %H:%M'),
        languages: git_service.repo_languages(check.repository.github_id),
        repo: git_service.repo_by_id(check.repository.github_id)
      }
    )
  end
end
