# frozen_string_literal: true

class SimpleProcessingService
  include NotificationConcern

  TMP_DIRECTORY = Rails.root.join('tmp_repos')

  def initialize(check_id)
    @check_id = check_id
    @check = Repository::Check.find(@check_id)
    raise StandardError, "Check not found, check_id:#{check_id}" unless @check

    @repo_id = @check.repository.github_id
  end

  def perform
    notify_clone_started

    git_client = Github::Client.new(user)
    @check.commit_id ||= git_client.last_commit(repo_id)[:id]

    target_dir = dir_name(repo_id, commit_id)

    create_directory(target_dir)

    git_client.clone(repo_id, commit_id, target_dir)

    # repo_languages = git_client.repo_languages(@check.repository.github_id)
    repo_language = git_client.primary_language(@check.repository.github_id)
    checks_list = BaseCheckService.checks_factory([repo_language])

    @check.result = checks_list.to_h do |c|
      check_result = c.new(target_dir).check
      [c.language, { success: check_result[0], result: check_result[1] }]
    end

    remove_directory(target_dir)

    status_finished
    notify_processing_finished
  rescue StandardError => e
    status_failed(e)
    Rails.logger.error "CloneJob failed\n #{e}"
    register_rollbar_error(e)
  end

  private

  def create_directory(target_dir)
    FileUtils.rm_rf(target_dir)
    FileUtils.mkdir_p(target_dir)
  end

  def remove_directory(target_dir)
    FileUtils.rm_rf(target_dir)
  end

  def dir_name(repo_id, commit_id)
    TMP_DIRECTORY.join(repo_id.to_s).join(commit_id).to_s
  end

  def repo_id
    @check.repository.github_id
  end

  def commit_id
    @check.commit_id
  end

  def user
    @check.repository.user
  end

  def status_finished
    @check.end_processing
    @check.passed = @check.passed?
    @check.save!
  end

  def status_failed(exception)
    @check.fail
    @check.error = exception
    @check.save!
  end

  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception')
  end
end
