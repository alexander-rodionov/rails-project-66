# frozen_string_literal: true

require 'securerandom'
require 'fileutils'

class StorageManagementService < BaseCustomService
  CACHE_KEY = 'tmp_dirs'
  CACHE_LIFETIME = 1.day
  TMP_DIRECTORY = Rails.root.join('tmp_repos')

  def self.repo_directory_alive?(repo_id, commit_id)
    dir = dir_name(repo_id, commit_id)
    if Dir.exist?(dir) && required_dirs.include?(dir)
      true
    else
      FileUtils.rm_rf(dir)
      false
    end
  end

  def self.acquire_directory(repo_id, commit_id)
    dir = dir_name(repo_id, commit_id)
    register_dir(dir)
    FileUtils.rm_rf(dir)
    FileUtils.mkdir_p(dir)
    dir
  end

  def self.clean_up_directories(complete: false)
    existing_dirs = Dir.glob("#{TMP_DIRECTORY}/*")
    if complete
      FileUtils.rm_rf(existing_dirs)
    else
      (existing_dirs - required_dirs).each do |dir|
        FileUtils.rm_rf(dir)
      end
    end
  end

  def self.register_dir(dir)
    write_cache(required_dirs + [dir])
  end

  def self.unregister(dir)
    write_cache(required_dirs - [dir])
  end

  def self.required_dirs
    Rails.cache.read(CACHE_KEY) || []
  end

  def self.write_cache(val)
    Rails.cache.write(CACHE_KEY, val, expires_in: CACHE_LIFETIME)
  end

  def self.dir_name(repo_id, commit_id)
    TMP_DIRECTORY.join(repo_id.to_s).join(commit_id).to_s
  end
end
