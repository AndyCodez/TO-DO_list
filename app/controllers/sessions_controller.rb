class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      if user.created_at > 2.days && !user.activated?
        #Deny full access to app functionality
        flash[:danger] = "Please check your email and activate your account."
        redirect_to root_url
      else
        #Allow access
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to lists_path
      end
    else
      flash.now[:danger] = "Invalid name/password combination."
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
