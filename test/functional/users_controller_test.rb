require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = User.find_all_by_username(:one)
  end

  test "the truth" do
    assert true
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  if false

  test "should create user" do
    assert_difference('User.count') do
      post :create, :@user=>{:first_name=>"abc", :last_name=>"abc", :email=>"abc@ncsu.edu", :username=>"example", :original_password=>"fixpassword1",:password=>"dsfdsg"}
    end

    assert_redirected_to user_path(assigns(:user))
  end


  test "should show user" do
    get :show, :id=> users(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: { password: "abc"}
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  end
end