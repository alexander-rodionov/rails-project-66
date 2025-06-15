# frozen_string_literal: true

class CheckRepositoryJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    CheckRepositoryService.new(check_id).perform
  end
end
