require 'test_helper'

class UserIntegrationTestTest < ActionDispatch::IntegrationTest
  fixtures :users
  test "the truth" do
   assert true
  end
   if false
  def test_login_page
    https!
    get "logins/new"
    assert_response :success
    post_via_redirect "/loginUser"  , :username => users(:one).username, :original_password => "password"
    assert_equal '/posts/index', path
    end
  end
  def test_new_user
    get "/users/new"
    assert_response :success
    post_via_redirect "/users"   ,:user=>{:username => "suneet" , :first_name =>"suneet" ,:last_name=> "sasidharan", :email =>"ssasidh@ncsu.edu",:original_password =>"suneet" }
    #click_button "Create User"
    @user = User.find_all_by_username("suneet").first
    assert_equal '/users/'+ @user.id.to_s , path
  end
end
