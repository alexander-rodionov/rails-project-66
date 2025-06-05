# frozen_string_literal: true

class BaseCustomService
  def initialize(*args)
    # nothing here
  end

  def run(command)
    Rails.logger.info("Running command #{command}")
    stdout_res, stderr_res, status_res = Open3.capture3(command)
    [stdout_res, stderr_res, status_res]
  end

  private

  def not_implemented_error
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception')
  end
end
