require 'test_helper'

class EditionsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get editions_show_url
    assert_response :success
  end

end
