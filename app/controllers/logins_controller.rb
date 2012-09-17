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
    flash[:message]  = "in login"
    if request.post?
      session[:userid] = User.authenticate(params[:username], params[:password])
      if session[:userid] != nil
        puts "***authenticated!"
        flash[:message]  = "Login successful"
        redirect_to(:controller=>:posts,:action=>:index)
      else
        flash[:warning] = "Login unsuccessful "   + params[:username] + params[:password]
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
