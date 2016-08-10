require 'test_helper'

class TodoListTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:makatunga)
  end

  test "user should be able to create a list" do
    log_in_as  @user
    assert is_logged_in?
    get lists_path
    assert_difference "List.count", 1 do
      post lists_path, params:{ list: { title: "My List Title" } } 
    end
    follow_redirect!
    assert_not flash.empty?
    assert_template 'lists/index'
  end
end
