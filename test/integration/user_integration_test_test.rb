require 'test_helper'

class UserIntegrationTestTest < ActionDispatch::IntegrationTest
  fixtures :users
  test "the truth" do
   assert true
  end

  def test_login_page
    get "/login"
    assert_response :success
    post "/logins/new"  , :username => users(:one).username, :password => "password"
    #post_via_redirect "/logins", :username => users(:one).username, :password => "password"
    assert_equal '/posts/index', path

  end
end
