# frozen_string_literal: true

class SimpleProcessingJob < ApplicationJob
  queue_as :default

  def perform(check_id)
    SimpleProcessingService.new(check_id).perform
  end
end
