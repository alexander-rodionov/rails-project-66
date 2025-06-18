# frozen_string_literal: true

require_relative '../../lib/github/client'

class CheckRepositoryService
  include NotificationConcern
  include ActiveModel::Validations

  TMP_DIRECTORY = Rails.root.join('tmp_repos')

  attr_reader :check

  validates :check, presence: true

  def initialize(check_id)
    @check = Repository::Check.find(check_id)
    raise StandardError, "Check not found, check_id:#{check_id}" unless @check

    @repo_id = @check.repository.github_id
  end

  def perform
    return false unless valid?

    notify_clone_started

    git_client = Github::Client.new(user)
    @check.commit_id ||= git_client.last_commit(repo_id)[:id]

    target_dir = dir_name(repo_id, commit_id)

    create_directory(target_dir)

    git_client.clone(repo_id, commit_id, target_dir)

    repo_language = git_client.primary_language(@check.repository.github_id)
    checks_list = BaseCheckService.checks_factory([repo_language])

    @check.result = checks_list.to_h do |check|
      check_result = check.new(target_dir).check
      [check.language, { success: check_result[0], result: check_result[1] }]
    end

    remove_directory(target_dir)

    finish
    notify_processing_finished

    true
  rescue StandardError => e
    fail(e)
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

  def finish
    @check.end_processing
    @check.passed = @check.passed?
    @check.save!
  end

  def fail(exception)
    @check.fail
    @check.error = exception
    @check.save!
  end

  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception')
  end
end
