class CardsController < ApplicationController
  def new
    @list = List.find_by(id: params[:list_id])
    @card = Card.new
  end

  def create
    #To help create card related to this list
    #and redirect to the current list
    list = List.find_by(id: params[:list_id])
    @card = list.cards.build(card_params)
    if @card.save
      flash[:success] = "Card added!"
      #Redirect to the same list 
      redirect_to list_path(id: list.id)
    else
      flash.now[:danger] = "Something went wrong, please try again."
      render 'new'
    end
  end

  def move_card
    @card = Card.find_by(id: params[:card_id])
    @lists = current_user.lists
  end

  def choose_list
    card = Card.find(params[:card_id]) 
    card.update_attribute(:list_id, params[:list_id])
    flash[:success] = "Card successfully moved!"
    #Redirect to the list the card has been moved to
    redirect_to list_path(id:params[:list_id])
  end

  private
    def card_params
      params.require(:card).permit(:title, :description)
    end
end
