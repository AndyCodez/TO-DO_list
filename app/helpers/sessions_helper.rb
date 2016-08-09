module SessionsHelper

  #Logs in the given user
  def log_in(user)
    #Store the user's id in a temporary session called :user_id
    session[:user_id] = user.id
  end

  #Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.signed[:user_id] = { value: user.id, expires: 7.days.from_now }
    cookies[:remember_token] = { value: user.remember_token, expires: 7.days.from_now }
  end

  #Returns the current logged in user if any
  def current_user
    if (user_id = session[:user_id])
    #Retrieves the stored session[:user_id], by finding the user in the db
    #corresponding to the session id
    @current_user ||= User.find_by(id: user_id) 
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  #Returns true if user is logged in
  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #Logs out the current user
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  #Returns the period length between signup and the current time
  def time_from_signup(user)
    now = Time.zone.now
    signup_time = user.created_at
    now - signup_time
  end

end
