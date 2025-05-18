# frozen_string_literal: true

require 'securerandom'
require 'fileutils'

class StorageManagementService
  CACHE_KEY = 'tmp_dirs'
  CACHE_LIFETIME = 1.day
  TMP_DIRECTORY = Rails.root.join('tmp/repos')

  def self.acquire_tmp_directory
    dir = TMP_DIRECTORY.join(SecureRandom.uuid).to_s
    FileUtils.rm_rf(dir)
    Dir.mkdir(dir)
    register_dir(dir)
    dir
  end

  def self.release_tmp_directory(dir)
    unregister_dir(dir)
    FileUtils.rm_rf(dir)
  end

  def self.clean_up_directories
    existing_dirs = Dir.glob("#{TMP_DIRECTORY}/*")
    (existing_dirs - required_dirs).each do |dir|
      FileUtils.rm_rf(dir)
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

end