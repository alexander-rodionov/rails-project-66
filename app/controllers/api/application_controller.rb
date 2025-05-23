# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    def register_rollbar_error(exception = nil)
      Rollbar.error(exception || 'No exception',
                    request: request,
                    user: current_user,
                    params: params.to_unsafe_h)
    rescue StandardError => e
      Rails.logger.warn "Rollbar exception #{e}"
    end
  end
end
