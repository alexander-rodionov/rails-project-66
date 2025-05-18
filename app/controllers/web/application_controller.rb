# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    allow_browser versions: :modern

    def current_user
      @current_user ||= User.take
    end
  end
end
