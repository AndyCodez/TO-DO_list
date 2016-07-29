class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      redirect_to user
    else
      flash[:danger] = "Invalid name/password combination."
      render 'new'
    end
  end
end
