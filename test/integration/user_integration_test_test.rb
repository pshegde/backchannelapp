require 'test_helper'

class UserIntegrationTestTest < ActionDispatch::IntegrationTest
  fixtures :all
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
  def test_flow
    # create user
    get "/users/new"
    assert_response :success
    post_via_redirect "/users"   ,:user=>{:username => "suneet" , :first_name =>"suneet" ,:last_name=> "sasidharan", :email =>"ssasidh@ncsu.edu",:original_password =>"suneet" }

    @user = User.find_all_by_username("suneet").first
    assert_equal 'User was successfully created.',flash[:notice]
    assert_equal '/users/'+ @user.id.to_s , path

    #create post
    get "posts/new"
    assert_response :success
    @category = Category.find_all_by_name("MyString").first
    @request.session[:user_id] = @user
    post_via_redirect "/posts" ,:post => {:content=>"test post",:Category_id=>@category.id , :title=>"test title", :num_votes=>1 }
    @post = Post.find_all_by_content("test post").first
    assert_equal 'Post was successfully created.',flash[:notice]
    assert_equal '/posts/'+ @post.id.to_s ,path

    # votes
    @request.session[:user_id] = @user
    #@request.session[:post_id_passed] = posts(:onepost).id
    # vote on someone else's post
    get_via_redirect '/voteforpost/incrementVote?post_id_for_vote='+posts(:onepost).id.to_s
    assert_equal 'Your vote was registered successfully.' ,flash[:alert]

    #vote on your own post
    get_via_redirect '/voteforpost/incrementVote?post_id_for_vote='+@post.id.to_s
    assert_equal 'Sorry. You cannot vote for your own post.' ,flash[:alert]

    get_via_redirect '/commentsforpost/new?post_id_passed='+@post.id.to_s , :comment =>{:content=>"test comment"}
    assert_response :success

    @request.session[:post_id_passed] = @post.id
    post_via_redirect "/comments", :comment => {:content=>"test comment" }

    assert_equal 'Comment was successfully created.',flash[:notice]

    #logout
    get "logout"
    assert_equal 'Successfully Logged out', flash[:alert]
  end
end
