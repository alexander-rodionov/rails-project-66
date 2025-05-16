# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
# require_relative '../code/config/environment'
require 'rails/test_help'
require 'webmock/minitest'

OmniAuth.config.test_mode = true
# WebMock.disable_net_connect!
test_path = File.expand_path('fixtures', __dir__)


ActiveSupport::TestCase.fixture_paths = [test_path]

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  setup do
    queue_adapter.perform_enqueued_jobs = true
    queue_adapter.perform_enqueued_at_jobs = true
  end
end

class ActionDispatch::IntegrationTest
  include Minitest::PowerAssert::Assertions

  def sign_in(user, _options = {})
    auth_hash = {
      provider: 'github',
      uid: '12345',
      credentials: {
        token: '12345'
      },
      info: {
        email: user.email,
        name: user.nickname
      }
    }

    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash::InfoHash.new(auth_hash)

    get callback_auth_url('github')
  end

  def signed_in?
    session[:user_id].present? && current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def log_params(params)
    puts "\nRunning spec #{self.class}:#{name} with params: #{params}"
  end
end

