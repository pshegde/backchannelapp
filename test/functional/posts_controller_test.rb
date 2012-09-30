require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = Post.find_all_by_title(:onepost)
    @user = User.find_all_by_username('pshegde').first
    @category = Category.find_all_by_name("MyString").first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    @request.session[:user_id] = @user
    get :new
    assert_response :success
  end

  test "should create post" do
    assert_difference('Post.count') do
      @request.session[:user_id] = @user
      post :create, :post => {:content=>"content",:Category_id=>@category.id , :title=>"title", :num_votes=>1 }
    end
    assert_equal 'Post was successfully created.', flash[:notice]
    assert_redirected_to post_path(assigns(:post))
  end

  test "should get edit" do
    get :edit, id: posts(:onepost).id
    assert_response :success
  end

  test "should update post" do
    @request.session[:user_id] = @user
    put :update, id: posts(:onepost).id, post: { :content=>"newcontent" }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should show user" do
    get :show, :id=> posts(:onepost).to_param
    assert_response :success
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete :destroy, id: posts(:twopost).to_param
    end
    assert_redirected_to posts_path
  end
end
