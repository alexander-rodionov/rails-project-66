# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :handle_error if Rails.env.production?

  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception',
                  request: request,
                  user: current_user,
                  params: params.to_unsafe_h)
  rescue StandardError => e
    Rails.logger.warning "Rollbar exception #{e}"
  end

  def handle_error(exception)
    register_rollbar_error(exception)
    redirect_back(fallback_location: root_path)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  rescue StandardError
    session[:user_id] = nil
    @current_user = nil
  end
end
