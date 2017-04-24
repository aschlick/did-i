require 'test_helper'

class ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    sign_in()
    get items_url
    assert_response :success
  end

  test "is redirected to user sign in" do
    get items_url
    assert_response :redirected
  end

end
