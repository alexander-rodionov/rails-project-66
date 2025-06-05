# frozen_string_literal: true

module Api
  class ChecksController < Api::ApplicationController
    def create
      event_type = request.headers['X-GitHub-Event'] || 'push'
      case event_type
      when 'ping'
        head :ok
        Rails.logger.info("GitHub hook alive: #{params[:hook][:id]}")
      when 'push'
        repository_id = params[:repository][:id]
        repository = Repository.find_by(github_id: repository_id)

        head :not_found if repository.nil?

        repository.checks.create!

        OrchestratorJob.perform_now if IMMEDIATE_START
        head :ok
      end
    rescue StandardError => e
      register_rollbar_error(e)
      Rails.logger "Hook processing error #{e}"
    end
  end
end
