class LoginsController < ApplicationController
  # GET /logins
  # GET /logins.json
  def index
    @logins = Login.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logins }
    end
  end

  # GET /logins/1
  # GET /logins/1.json
  def show
    @login = Login.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @login }
    end
  end

  # GET /logins/new
  # GET /logins/new.json
  def new
    #@login = Logins.new
    #flash[:notice] = nil
    #respond_to do |format|
     #format.html # new.html.erb
    #format.json { render json: @login }
    #end

  end

  # GET /logins/1/edit
  def edit
    @login = Login.find(params[:id])
  end

  # POST /logins
  # POST /logins.json
  def loginUser
    #flash[:notice]  = "in login"   + params[:username]
    if request.post?
      session[:user_id] = User.authenticate(params[:username], params[:original_password])
      if session[:user_id] != nil
        #flash[:notice]  = "Login successful"
        #check if admin redirect to admin page
        if session[:user_id].admin == true
          session[:isadmin] =  true
          redirect_to(:controller=>:admins,:action=>:index)
        else
          #check if not admin redirect to posts
          session[:isadmin] =  false
          redirect_to(:controller=>:posts,:action=>:index)
        end
      else
        flash[:alert] = "Login unsuccessful"
        redirect_to(:controller=>:logins,:action=>:new)
      end
    end
  end

  # PUT /logins/1
  # PUT /logins/1.json
  def update
    @login = Login.find(params[:id])

    respond_to do |format|
      if @login.update_attributes(params[:login])
        format.html { redirect_to @login, notice: 'Login was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @login.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logins/1
  # DELETE /logins/1.json
  def destroy
    @login = Login.find(params[:id])
    @login.destroy

    respond_to do |format|
      format.html { redirect_to logins_url }
      format.json { head :no_content }
    end
  end
end
