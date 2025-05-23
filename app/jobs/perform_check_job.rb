# frozen_string_literal: true

class PerformCheckJob < ApplicationJob
  queue_as :default
  attr_accessor :check

  def perform(check_id)
    logger.info 'PerformCheckJob started'

    @check = Repository::Check.find(check_id)
    gs = GitService.new @check.repository.user
    check_list = BaseCheckService.checks_factory(
      gs.repo_languages(@check.repository.github_id)
    )

    if check_list.empty?
      status_no_checks
    else
      status_start_processing
      raise StandardException, 'Repo directory has been already cleared' \
          unless StorageManagementService.repo_directory_alive?(@check.repository.github_id, @check.commit_id)

      clone_dir = StorageManagementService.dir_name(@check.repository.github_id, @check.commit_id)

      @check.result = check_list.to_h do |c|
        check_result = c.new(clone_dir).check
        [c.language, { success: check_result[0], result: check_result[1] }]
      end

      status_end_processing
      logger.info 'PerformCheckJob success'
      begin
        CheckMailer.finished(@check).deliver_now
      rescue StandardError => e
        Rails.logger.error "Finished email sending failure #{e}"
        register_rollbar_error(e)
      end
    end
  rescue StandardError => e
    status_failed(e)
    logger.info 'PerformCheckJob failed'
    register_rollbar_error(e)
    CheckMailer.finished(@check).deliver_now
  end

  def status_no_checks
    @check && ActiveRecord::Base.transaction do
      @check.no_checks
      @check.save!
    end
  end

  def status_start_processing
    @check && ActiveRecord::Base.transaction do
      @check.start_processing
      @check.save!
    end
  end

  def status_end_processing
    @check && ActiveRecord::Base.transaction do
      @check.end_processing
      @check.passed = @check.passed?
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
end
