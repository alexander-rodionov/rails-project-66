# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    allow_browser versions: :modern

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue StandardError
      # TODO: Rollbar
      session[:user_id] = nil
      @current_user = nil
    end
  end
end
