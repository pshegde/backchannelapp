require 'test_helper'

class UserIntegrationTestTest < ActionDispatch::IntegrationTest
  fixtures :users
  test "the truth" do
   assert true
  end

  def test_login_page
    https!
    get "logins/new"
    assert_response :success
    post_via_redirect "logins/new"  , :username => users(:one).username, :password => "password"

    #post_via_redirect "/logins", :username => users(:one).username, :password => "password"
    assert_equal '/posts/index', path

  end
end
