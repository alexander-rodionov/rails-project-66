# frozen_string_literal: true

require 'test_helper'

class RepositoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users :one
    sign_in user
  end

  test 'index' do
    get repositories_url
    assert_response :success
  end

  test 'new' do
    puts WebMock::StubRegistry.instance.request_stubs.inspect
    get new_repository_url
    assert_response :success
  end

  test 'create' do
    puts WebMock::StubRegistry.instance.request_stubs.inspect
    id = Faker::Number.number(digits: 10)
    attrs = { github_id: id }

    log_params({ repository: attrs }.to_json)

    post repositories_url, params: { repository: attrs }
    assert_response :redirect

    repository = Repository.find_by github_id: id

    assert { repository }

    # NOTE: репозиторий напи прысылает github client из контейнера. В тестах это делает stub
    # Конкретное имя репозитория не проверяем, чтобы не навязывать проверку на конкретные данные
    assert { repository.language.present? }
    assert { repository.full_name.present? }
  end

  test 'show' do
    repository = repositories :hexlet_basics

    get repository_url(repository)
    assert_response :success
  end
end
