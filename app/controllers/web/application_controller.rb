# frozen_string_literal: true

module Web
  class ApplicationController < ApplicationController
    allow_browser versions: :modern
  end
end
