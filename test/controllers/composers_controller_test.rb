require 'test_helper'

class ComposersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get composers_show_url
    assert_response :success
  end

end
