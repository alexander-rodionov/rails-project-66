# frozen_string_literal: true

require 'test_helper'

module Api
  class ChecksControllerTest < ActionDispatch::IntegrationTest
    test 'create' do
      repository = repositories :without_checks

      payload = {
        repository: {
          id: repository.github_id,
          full_name: repository.full_name
        }
      }

      log_params(payload.to_json)
      post api_checks_url, params: payload, as: :json
      assert_response :ok

      # NOTE: можно избавиться от last?
      check = repository.checks.last

      assert { check }
      assert { check.finished? }
      assert { check.passed }
    end
  end
end
