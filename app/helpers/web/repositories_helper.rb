# frozen_string_literal: true

module Web
  module RepositoriesHelper
    SUPPORTED_LANGUAGES = %w[Ruby].freeze
    def available_projects
      all_repos = Github::Client.new(controller.current_user)
                                .repos
                                .filter { |r| SUPPORTED_LANGUAGES.include? r[:language] }
                                .map { |r| [r[:name], r[:id]] }
      assigned_repos = controller.current_user.repository.pluck(:github_id)
      all_repos.filter { |r| assigned_repos.exclude?(r[1]) }.sort_by { |a| a[0] }
    end
  end
end
