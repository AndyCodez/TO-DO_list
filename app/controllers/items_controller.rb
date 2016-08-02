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
      redirect_to root_url
    else
      flash[:danger] = "Something went wrong. Please, try again."
      render 'new'
    end
  end

  private
    def item_params
      params.require(:item).permit(:activity, :condition)
    end

end
