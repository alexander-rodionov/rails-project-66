# frozen_string_literal: true

module Utils
  class CommandLauncher
    def self.run(command)
      Rails.logger.info("Running command #{command}")
      stdout_res, stderr_res, status_res = Open3.capture3(command)
      [stdout_res, stderr_res, status_res]
    end

    def self.git_clone(auth_url, target_dir)
      run("git clone #{auth_url} #{target_dir}")
    end

    def self.eslint(dir)
      run("npx eslint --config eslint.config.mjs --format json #{dir}")
    end

    def self.rubocop(dir)
      run("rubocop --force-default-config --format json #{dir}")
    end
  end
end
