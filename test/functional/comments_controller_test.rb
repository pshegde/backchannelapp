require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  setup do
    @post = Post.find_all_by_title('MyString').first
    @comment = Comment.find_all_by_content("MyString").first
    @user = User.find_all_by_username('pshegde').first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comments)
  end

  test "should get new" do
    @request.session[:user_id] = @user
    get :new, :post_id_passed => @post.id
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      @request.session[:user_id] = @user
      @request.session[:post_id_passed] = @post.id
      post :create, :comment => { content: "comment test." }
    end
    assert_equal 'Comment was successfully created.', flash[:notice]
    assert_redirected_to comment_path(assigns(:comment))
  end

  test "should show comment" do
    get :show, id: comments(:onecomment).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: comments(:onecomment).id
    assert_response :success
  end

  test "should update comment" do
    put :update, id: comments(:onecomment).id, comment: { content: "newcomments ..."}
    assert_equal 'Comment was successfully updated.', flash[:notice]
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: comments(:onecomment).id
    end
    assert_redirected_to posts_path
  end
end
