# frozen_string_literal: true

require_relative '../../../lib/github/client'

module Web
  class RepositoriesController < Web::ApplicationController
    include Pundit::Authorization

    before_action -> { authorize Repository }
    before_action :set_github_id, only: :create
    before_action :set_repository, only: :show

    def index
      @repositories = Repository.where(user: current_user)
    end

    def show
      redirect_to :repositories unless @repository
    end

    def new
      @repository = Repository.new
    end

    def create
      if @github_id.blank? || @github_id.zero?
        redirect_to :new_repository
        return
      end

      git_client = Github::Client.new(current_user)
      repo = git_client.repo_by_id(@github_id)
      Repository.create!(
        user: current_user,
        name: repo[:name],
        full_name: repo[:full_name] || 'Not set',
        language: git_client.primary_language(@github_id),
        github_id: @github_id,
        web_path: repo[:html_url],
        clone_path: repo[:clone_url]
      )
      git_client.register_hook(@github_id, ENV.fetch('BASE_URL', ''))
      redirect_to repositories_path
    end

    private

    def set_github_id
      @github_id = params.require(:repository).permit(:github_id)[:github_id].to_i
    end

    def set_repository
      @repository = Repository.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @repository = nil
    end
  end
end
