# frozen_string_literal: true

class BaseService
  def run(command)
    stdout_res, stderr_res, status_res = Open3.capture3(command)
    [stdout_res, stderr_res, status_res]
  end

  private

  def not_implemented_error
    raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
  end

  def register_rollbar_error(exception = nil)
    Rollbar.error(exception || 'No exception',
                  request: request,
                  user: current_user,
                  params: params.to_unsafe_h)
  end
end
