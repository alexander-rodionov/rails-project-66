class RubyCheckService < BaseCheckService

  def check
    rubocop_command = "rubocop #{dir}"
    response = system(rubocop_command)
    debugger
  end
    
end