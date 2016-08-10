class CardsController < ApplicationController

  skip_before_filter :verify_authenticity_token, :only => :create


  def create
    #To help create card related to this list
    #and redirect to the current list
    list = List.find_by(id: params[:list_id])
    @card = list.cards.build(card_params)
    if @card.save
      #Flash and redirect to the same list
      flash[:success] = "Card added!"
      #Redirect to the same list 
      redirect_to list_path(id: list.id)
    else
      flash[:danger] = "Something went wrong, please try again."
      respond_to do |format|
        #Executes if js is disabled on browser
        format.html { redirect_to list_path(id: list.id)}
        #Executes if js is enabled on browser
        format.js { redirect_to list_path(id: list.id) }
      end
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
