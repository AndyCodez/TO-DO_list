require 'test_helper'

class TodoListTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:makatunga)
    @list = lists(:listi)
    @other_list = lists(:another_list)
    @card = cards(:card_one)
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
    get list_path(id: @list.id)
    assert_equal "Ndio Listi Hii", @list.title
    assert_difference "Card.count", 1 do
      post new_cards_path(list_id: @list.id), params:{ card: { title: "Card title here", 
                                     description: "About the card" } }
    end
    assert_not flash.empty?
    assert_equal 'Card added!', flash[:success]
    #Move cards between lists
    get move_card_path(card_id: @card.id) 
    get choose_list_path(card_id: @card.id, list_id: @other_list.id) 
    assert_redirected_to list_path(id: @other_list.id)
    assert_not flash.empty?
    assert_equal 'Card successfully moved!', flash[:success]
  end
end
