# frozen_string_literal: true

class GitService
  CACHE_LIFETIME = 15.minutes
  TEMP_DIR = 
  def initialize(user)
    @user = user
  end

  def user
    p load_user
    load_user.to_h.slice(:id, :login, :url, :repos_url)
  end

  def repos
    load_repos.map { |r| r.to_h.slice(:id, :name, :clone_url) }
  end

  def clone(repo_name)
    repo = repos.filter{|i| i[:name] == repo_name}
    raise StandardError('No proper repository found') if repo.nil? || repo.size>1

    clone_url = repo[0][:clone_url]
    target_dir = StorageManagementService.acquire_tmp_directory
    auth_url = clone_url.gsub('https://', "https://#{@user.token}@")
    result = system("git clone #{auth_url} #{target_dir}")
    result ? target_dir : nil
  end

  private

  def load_user
    cached("user_#{@user.id}_user") do
      client.user
    end
  end

  def load_repos
    cached("user_#{@user.id}_user") do
      client.repos({}, query: { type: 'owner', sort: 'asc' })
    end
  end

  def cached(cache_key)
    data = Rails.cache.read(cache_key)
    return data if data.present?

    data = yield
    Rails.cache.write(cache_key, data, expires_in: CACHE_LIFETIME)
    data
  end

  def client
    @client ||= Octokit::Client.new(access_token: @user.token)
  end
end
