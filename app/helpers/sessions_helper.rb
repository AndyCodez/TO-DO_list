module SessionsHelper

  #Logs in the given user
  def log_in(user)
    #Store the user's id in a temporary session called :user_id
    session[:user_id] = user.id
  end

end
