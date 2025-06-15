# frozen_string_literal: true

module Web
  module RepositoriesHelper
    SUPPORTED_LANGUAGES = %w[Ruby JavaScript].freeze
    def available_projects
      all_repos = Github::Client.new(controller.current_user)
                                .repos
                                .filter { |repo| SUPPORTED_LANGUAGES.include? repo[:language] }
                                .map { |repo| [repo[:name], repo[:id]] }
      assigned_repos = controller.current_user.repository.pluck(:github_id)
      all_repos.filter { |repo| assigned_repos.exclude?(repo[1]) }.sort_by { |a| a[0] }
    end
  end
end
