# frozen_string_literal: true

require 'test_helper'

class ChecksControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users :one
    sign_in user
  end

  test 'show' do
    check = repository_checks :one

    get repository_check_url(check.repository, check)
    assert_response :success
  end

  test 'create' do
    repository = repositories :without_checks

    post repository_checks_url(repository)
    assert_response :redirect

    # NOTE: можно избавиться от last?
    check = repository.checks.last

    assert { check }
    assert { check.finished? }
    assert { check.passed }
  end
end
