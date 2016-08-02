class CardsController < ApplicationController
  def new
    @list = List.find_by(id: params[:list_id])
    @card = Card.new
  end

  def create
    @list = List.find_by(id: params[:list_id])
    @card = @list.cards.build(card_params)
    if @card.save
      flash[:success] = "Card added!"
      redirect_to root_url
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
