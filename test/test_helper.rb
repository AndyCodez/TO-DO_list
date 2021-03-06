ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if test user is logged in
  def is_logged_in?
    !session[:user_id].nil?
  end

  #f  ogs in a test user
  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    remember_me = options[:remember_me] || '1'

    if integration_test?
      #Login by posting to the sessions path
      post sessions_path, params: {
        session:{ name: user.name, 
                  password: password,
                  remember_me: remember_me
      }
      }
    else
      #Login using the session
      session[:user_id] - user.id
    end
  end

  private
  #Returns true inside an integration test
  def integration_test?
    defined?(post_via_redirect)
  end
end
