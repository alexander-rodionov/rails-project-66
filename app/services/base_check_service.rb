class BaseCheckService
  attr_accessor :dir, :result
  
  def initialize(dir)
    @dir = dir
  end

  def check(dir); end

  
end
