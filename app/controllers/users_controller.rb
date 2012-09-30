
class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def search
    #@user = User.find_by_username(params[:input])
    #if @user != nil
      @posts = Post.find_by_sql("select * from posts where posts.User_id in (select id from users where UPPER(users.username) like UPPER('%#{params[:input]}%'))")
      if @posts.size != 0
        if session[:user_id] == nil
          #session[:]earch.html.erb
          flash[:notice] = "Posts found are listed below:"
          #redirect_to :controller => "users", :action => "search"
        else
          flash[:alert] = "Posts found are listed below: "
          redirect_to :controller => "posts", :action => "index", :input => params[:input], :search => :user
        end
      else
        flash[:notice] = "No posts found for input: "+params[:input].to_s+"! Please try again."
        #redirect_to :controller => "posts", :action => "index"
      end
    #else
     # flash[:notice] = "No user found for search input: "+params[:input].to_s
      #redirect_to :controller => "posts", :action => "index"
    #end

  end
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    @user.admin=false
    respond_to do |format|
      if @user.save
        if session[:user_id].nil?
          session[:user_id] = @user
          session[:isadmin] = false
          flash[:alert] = "You have successfully logged in"
          #redirect_to :controller => "posts", :action => "index"
        end
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
    #redirect_to :controller => "posts", :action => "index"
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @votesForUser = Vote.where('User_id=' + params[:id].to_s)

    @votesForUser.each do |vote|
      @allposts =  Post.where('id=' + vote.Post_id.to_s)
      @allposts.each do |post|
        post.update_attributes(:num_votes => Integer(post.num_votes) - 1)
      end
     end

    @votesForCommentByUser = CommentVote.where('User_id=' + params[:id].to_s)

    @votesForCommentByUser.each do |comment_vote|
      @allcomments =  Comment.where('id=' + comment_vote.Comment_id.to_s)
      @allcomments.each do |comm|
        comm.update_attributes(:num_votes => Integer(comm.num_votes) - 1)
      end
    end

    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

 def whovotedpost
    @peopleVoted = Vote.find_all_by_Post_id(params[:post_id_voted])
    @userVoted = []
    @peopleVoted.each do |vote|
      if vote.User_id != session[:user_id].id
        @userVoted << User.find(vote.User_id)
      end
    end
    #format.html { render action: "whovotedpost" }
 end

  def whovotedcomment
    @peopleVoted = CommentVote.find_all_by_Post_id(params[:post_id_voted])
    @userVotedOnComment = []
    @peopleVoted.each do |vote|
      if vote.User_id != session[:user_id].id
        @userVotedOnComment << User.find(vote.User_id)
      end
    end
  end

  def postsSearched
    @@postsSearched
  end

end

