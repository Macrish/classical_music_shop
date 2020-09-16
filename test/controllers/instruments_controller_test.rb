require 'test_helper'

class InstrumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get instruments_show_url
    assert_response :success
  end

end
