require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get welcome" do
    get main_welcome_url
    assert_response :success
  end

end
