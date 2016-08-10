class AccountActivationsController < ApplicationController
  before_action :check_expiration, only: [:edit]

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = "Account activated!"
      redirect_to lists_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  def create
    @user = User.find_by(email: params[:account_activation][:email].downcase)
    if @user == current_user
      @user.create_activation_digest
      @user.send_activation_email
      flash[:success] = "Check your email for activation instructions"
      redirect_to root_url
    else
      flash.now[:alert] = "Incorrect email address!"
      render 'new'
    end
  end

  private
  def check_expiration
    user = User.find_by(email: params[:email])
    if user.activation_token_expired?
      flash[:alert] = "Sorry, your activation link has expired."
      redirect_to root_url
    end
  end
end
