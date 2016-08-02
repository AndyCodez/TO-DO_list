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

  private
    def card_params
      params.require(:card).permit(:title, :description)
    end
end
