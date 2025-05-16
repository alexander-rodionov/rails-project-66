require "test_helper"

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do

    dir_list = Dir.glob("#{Rails.root}/**/")
    (dir_list.filter { |f| !(f=~/tmp|vendor|storage|node_modules/)}). each { |x| p x}

    get welcome_index_url
    assert_response :success
  end
end
