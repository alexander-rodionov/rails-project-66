class Web::ApplicationController < ApplicationController
  allow_browser versions: :modern

  def current_user
    @current_user =1
  end
end