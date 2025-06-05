# frozen_string_literal: true

module RepositoryHelper
  def last_check_status(repository)
    repository.checks.order(created_at: :desc).first&.passed&.to_s || 'false'
  end
end
