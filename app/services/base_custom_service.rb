# frozen_string_literal: true

class BaseCustomService
  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception')
  end
end
