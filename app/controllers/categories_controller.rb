class CategoriesController < ApplicationController
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/1
  # GET /categories/1.json
  def search
    #@posts = Post.find_all_by_content(params[:input])
    @posts = Post.find_by_sql("select * from posts where Category_id in (select id from categories where upper(name) like upper('%#{params[:input]}%'))")
    #@posts = Post.where("content LIKE '%#{params[:input]}%'")
    #Category.joins(:posts)
    #@categories = Category.find_all_by_name(params[:input])
    #@categories = Category.where("name LIKE '%#{params[:input]}%'")


    #@posts = Category.select("id").where(name: '(params[:input])')
    #@posts= Post.find_all_by_Category_id(LIKE (Category.select("Category_id").where(Category.find_all_by_name(params[:input]))))
    #@categories = Category.find(params[:input])
    #@cat_id = Post.where ("categories: LIKE ")
    #@posts = Post.where("Category_id LIKE @cat_id.id")#, :cat_id => '%#{ Category.fi (param[:input])}%')
    #@posts = Post.where("content LIKE ?","%"+(params[:input])+"%")
    if @posts.length != 0
        if session[:user_id] == nil
          flash[:notice] = "Posts found are listed below:"
          respond_to do |format|
            format.html # search.html.erb
            format.json { render json: @posts_search }
          end
          #redirect_to :controller => :users, :action => :search
        else
          flash[:notice] = "Posts found are listed below:"
          redirect_to :controller => "posts", :action => "index", :input => params[:input], :search => :category
     end
    else
      flash[:notice] = "No posts found for input: "+params[:input].to_s+" ! Please try again."
      #redirect_to :controller => "posts", :action => "index"
    end

  end

  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

end
