require 'test_helper'

class TodoListTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:makatunga)
    @list = lists(:listi)
  end

  test "user should be able to create a list" do
    log_in_as  @user
    assert is_logged_in?
    get lists_path
    assert_difference "List.count", 1 do
      post lists_path, params:{ list: { title: "My List Title" } } 
    end
    assert_not flash.empty?
    assert_equal 'List successfully created!', flash[:success]
  end

  test "user should be able to add card to a list" do
    log_in_as @user
    assert is_logged_in?
    get lists_path
    get list_path(id: 2)
    assert_equal "Ndio Listi Hii", @list.title
    assert_difference "Card.count", 1 do
      post new_cards_path(list_id: @list.id), params:{ card: { title: "Card title here", 
                                     description: "About the card" } }
    end
    assert_not flash.empty?
    assert_equal 'Card added!', flash[:success]
  end
end
