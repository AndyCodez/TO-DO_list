module SessionsHelper

  #Logs in the given user
  def log_in(user)
    #Store the user's id in a temporary session called :user_id
    session[:user_id] = user.id
  end

  #Returns the current logged in user if any
  def current_user
    #Retrieves the stored session[:user_id], by finding the user in the db
    #corresponding to the session id
    @current_user ||= User.find_by(id: session[:user_id]) 
  end

  #Returns true if user is logged in
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
