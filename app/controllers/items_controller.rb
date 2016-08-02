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

  def mark_done
    item = Item.find_by(id: params[:item_id])
    item.update_attribute(:status, "done")
    flash[:success] = "TO-DO Item marked as done."
    redirect_back fallback_location: root_url
  end

  private
    def item_params
      params.require(:item).permit(:activity, :condition)
    end

end
