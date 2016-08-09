require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:makatunga)
    ActionMailer::Base.deliveries.clear
  end

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post sessions_path, params: { 
      session: { name: "", password: " "  } 
    }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information followed by logout" do
    get login_path
    post sessions_path, params: {
      session: { name: @user.name, password: 'password'   }

    }
    assert is_logged_in?
    assert_redirected_to lists_path
    follow_redirect!
    assert_template 'lists/index'
    assert_select "a[href=?]", logout_path
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    #simulates a user clicking logout in a second window
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", logout_path, count: 0
  end
end
