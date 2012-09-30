require 'test_helper'

class VotesControllerTest < ActionController::TestCase
  setup do
    @vote = votes(:onevote)
    @post = Post.find_all_by_title(:onepost).first
    @user = User.find_all_by_username('pshegde').first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vote" do
    assert_difference('Vote.count') do
      @request.session[:user_id] = @user
      post :create, vote: { :Post_id =>posts(:onepost).id }
    end

    assert_redirected_to vote_path(assigns(:vote))
  end

  test "should show vote" do
    get :show, id: votes(:onevote).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: votes(:onevote).id
    assert_response :success
  end

  test "should update vote" do
    @request.session[:user_id] = @user
    put :update, id: votes(:onevote).id, vote: { :Post_id =>posts(:onepost).id  }
    assert_redirected_to vote_path(assigns(:vote))
  end

  test "should destroy vote" do
    assert_difference('Vote.count', -1) do
      delete :destroy, id: votes(:onevote).id
    end

    assert_redirected_to votes_path
  end
end
