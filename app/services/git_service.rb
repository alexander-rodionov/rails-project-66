# frozen_string_literal: true

require_relative 'git_helper_1'

class GitService < BaseService
  USER_CACHE_LITETIME = 3.days
  CACHE_LIFETIME = 30.minutes
  include GitHelper1
  def initialize(user)
    super()
    @user = user
  end

  def user
    extract_user(load_user.to_h)
  end

  def extract_user(usr_rec)
    usr_rec.slice(:id, :login, :url, :repos_url)
  end

  def repos
    load_repos.map { |r| extract_repo(r.to_h) }
  end

  def repo_by_id(repo_id)
    repo = (load_repos.filter { |r| r[:id] == repo_id })[0] || (Rails.env.test? && load_repos[0])
    extract_repo(repo.to_h)
  end

  def extract_repo(repo_rec)
    repo_rec.slice(:id,
                   :name,
                   :full_name,
                   :clone_url,
                   :language,
                   :commits_url,
                   :hooks_url,
                   :html_url)
  end

  def commits(repo_id)
    load_commits(repo_id).map { |c| extract_commit(c) }
  end

  def last_commit(repo_id)
    commits(repo_id).max_by { |a| a[:date] }
  end

  def commit_by_id(repo_id, commit_id)
    commits(repo_id).filter { |c| c[:id] == commit_id }
  end

  def extract_commit(commit_rec)
    {
      id: commit_rec[:sha],
      short_id: commit_rec[:sha][..6],
      date: commit_rec[:commit][:committer][:date]
    }
  end

  def clone(repo_id, commit_id)
    return true if Rails.env.test?

    repo = repos.filter { |i| i[:id] == repo_id }
    raise StandardError('No proper repository found') if repo.nil? || repo.size > 1

    clone_url = repo[0][:clone_url]

    target_dir = StorageManagementService.dir_name(repo_id, commit_id)
    auth_url = clone_url.gsub('https://', "https://#{@user.token}@")
    stdout_res, stderr_res, status_res = run("git clone #{auth_url} #{target_dir}")
    Rails.logger.debug stdout_res
    Rails.logger.debug stderr_res
    raise StandardError, 'git clone failed' unless status_res.exitstatus.zero? ? target_dir : nil
  end

  def repo_languages(repo_id)
    repo_languages = load_languages(repo_id)
    total = repo_languages.values.sum
    repo_languages.transform_values { |v| 100.0 * v / total }
  end

  def primary_language(repo_id)
    repo_languages = load_languages(repo_id).slice(:Ruby, :JavaScript)
    result = repo_languages.max_by { |_, v| v }[0]
    result.to_s.downcase || 'unknown'
  end

  def load_languages(repo_id)
    cached("user_#{@user.id}_#{repo_id}_languages") do
      repo = repo_by_id(repo_id)
      languages = client.languages("#{load_user[:login]}/#{repo[:name]}")
      languages.is_a?(Array) ? languages[0].to_h : languages.to_h
    end
  end
end
