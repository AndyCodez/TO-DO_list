class RequestersController < ApplicationController

  def new
    requester = Requester.new(requester_params)
    if requester.save
      flash[:success] = "Request made!"
      redirect_to other_todos_path
    else
      flash[:danger] = "Something went wrong. Please, try again."
      redirect_to other_todos_path
    end
  end

  def requested_cards
    #Requests not made by this user
    @requesters = Requester.where.not(user_id: current_user.id)
  end

  private
    def requester_params
      params.permit(:card_id, :user_id)
    end
end
