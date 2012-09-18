class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index

    @posts = Post.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    @user = session[:user_id]
    #@post.votesnum = 0
    flash[:alert] = @user.id
    session[:post_id]=@post.id
    if @user != nil
        respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @post }
        end
        #redirect_to :controller => "posts", :action => "index"
    else
        flash[:alert] = "Please Login Before Posting"
        redirect_to :controller => "posts", :action => "index"
    end
   end
  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.User_id = session[:user_id]

    #@post.votesnum = 0
    respond_to do |format|
      if @post.save
        #session[:post_id] = @post.id
        #flash[:alert] = @post.id
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }

      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])
    @post.User_id = session[:user_id]
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])

    ###### Code block to delete the corresponding votes and comments #############

    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end
end
