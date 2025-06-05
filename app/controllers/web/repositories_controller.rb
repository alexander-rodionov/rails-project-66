# frozen_string_literal: true

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

      git_service = GitService.new(current_user)
      repo = git_service.repo_by_id(@github_id)

      Repository.create!(
        user: current_user,
        name: repo[:name],
        full_name: repo[:full_name],
        language: git_service.primary_language(@github_id),
        github_id: @github_id,
        web_path: repo[:html_url],
        clone_path: repo[:clone_url]
      )
      git_service.register_hook(@github_id, ENV.fetch('BASE_URL', ''))
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
