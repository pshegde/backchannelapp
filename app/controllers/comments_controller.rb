class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new
    @user = session[:user_id]
    session[:post_id_passed] = params[:post_id_passed]

    flash[:alert] =  session[:post_id_passed]
    if @user != nil
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @comment }
      end
    else
      flash[:alert] = "Please Login Before Posting"
      redirect_to :controller => "posts", :action => "index"
     end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    #@comment = Comment.new()
    @comment = Comment.new(params[:comment])
   @comment.Post_id= session[:post_id_passed]
   @comment.User_id = session[:user_id].id
    #@comment.post_id = session[:post_id]
    #@comment.post_id = params[:comment][:post_id]
    #flash[:alert] = @comment.post_id

    respond_to do |format|
      if @comment.save
        #update the updated date from comment table in post table
        @post = Post.find(@comment.Post_id)
        @post.update_attributes(:updated_at => @comment.updated_at)
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "new" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.json
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        #update the updated date from comment table in post table
        @post = Post.find(@comment.Post_id)
        @post.update_attributes(:updated_at => @comment.updated_at)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  def incrementVote
    @comment = Comment.find(params[:comment_id_for_vote])
    firstTimeVote = false
    if checkIfVotingAgain(params[:comment_id_for_vote],session[:user_id].id) == false
      firstTimeVote = true
    else
      flash[:alert] = "Sorry. You cannot vote for a comment more than once."
    end

    if session[:user_id].id == @comment.User_id
      flash[:alert] = "Sorry. You cannot vote on your own comment."
    end

    if session[:user_id].id != @comment.User_id  and firstTimeVote == true
      #1. insert in commentvote
      @CommentVote = CommentVote.new
      @CommentVote.Comment_id= params[:comment_id_for_vote]
      @CommentVote.User_id= session[:user_id].id   #user who voted
      @CommentVote.Post_id = Comment.find(params[:comment_id_for_vote]).Post_id
      @CommentVote.save

      #2. update numvotes in Post
      @comment.update_attributes(:num_votes => Integer(@comment.num_votes) +1)
      #update the updated date from comment table in post table
      @post = Post.find(@comment.Post_id)
      @post.update_attributes(:updated_at => @comment.updated_at)
      flash[:alert] = "Your vote for the comment was registered successfully."
    end
    redirect_to :controller => "posts", :action => "index"
  end

  def checkIfVotingAgain(comment_id,loggedin_user_id)
    @votes = CommentVote.all

    @votes.each do |vote|
      if  vote.User_id and  vote.Comment_id
        if vote.User_id.to_s == loggedin_user_id.to_s and vote.Comment_id.to_s == comment_id.to_s
          return true
        end
      end
    end
    return false
  end
end
