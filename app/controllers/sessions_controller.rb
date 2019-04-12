class SessionsController < ApplicationController
    def new
    end
  
    def create
      @user = User.find_by_email(params[:email])
      if @user&.authenticate(params[:password])
      # Equivalent to:
      # if user && user.authenticate(params[:password])
        # The 'session' is an object useable  in
        # controllers that uses cookies to store
        # encrypted data. To sign in a user, we store
        # their user_id in the session for later
        # retrieval
        session[:user_id] = @user.id
        redirect_to root_path, notice: "Logged in"
        # render json: session
      else
        flash[:alert] = "Wrong email or password"
        render :new
      end
    end

    def destroy
        session[:user_id] = nil
        flash[:notice] = "Logged out"
        redirect_to root_path
    end
  end
