require 'test_helper'

class CommentVotesControllerTest < ActionController::TestCase
  setup do
    @comment = Comment.find_all_by_content('MyString').first
    @comment_vote = CommentVote.find_by_Comment_id(@comment.id)
    @post = Post.find_all_by_title(:onepost).first
    @user = User.find_all_by_username('pshegde').first
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comment_votes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show comment_vote" do
    get :show, id: @comment_vote.id
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @comment_vote.id
    assert_response :success
  end

  test "should update comment_vote" do
    put :update, id: @comment_vote.id, comment_vote: {  }
    assert_redirected_to comment_vote_path(assigns(:comment_vote))
  end

  test "should destroy comment_vote" do
    assert_difference('CommentVote.count', -1) do
      delete :destroy, id: @comment_vote.id
    end

    assert_redirected_to comment_votes_path
  end
end
