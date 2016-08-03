class ItemsController < ApplicationController

  def new
    #For use to display the card's title
    #as well as for passing it's id as param on link
    @card = Card.find_by(id: params[:card_id])
    @item = Item.new
  end

  def create
    @card = Card.find_by(id: params[:card_id])
    @item = @card.items.build(item_params)
    if @item.save
      flash[:success] = "New to-do item added!"
      redirect_to list_path(id: @card.list_id) 
    else
      flash[:danger] = "Something went wrong. Please, try again."
      render 'new'
    end
  end

  def index
    @items = []
    public_items = Item.where(condition: "Public")
    public_items.each do |item|
      #The array should only contain items 
      #that don't belong to the current user
      if item.card.list.user != current_user
        @items << item
      end
    end
  end

  def mark_done
    item = Item.find_by(id: params[:item_id])
    item.update_attribute(:status, "done")
    flash[:success] = "TO-DO Item marked as done."
    redirect_back fallback_location: root_url
  end

  def undo
    item = Item.find_by(id: params[:item_id])
    item.update_attribute(:status, "incomplete")
    flash[:success] = "TO-DO Item has been undone."
    redirect_back fallback_location: root_url
  end

  private
    def item_params
      params.require(:item).permit(:activity, :condition)
    end

end
