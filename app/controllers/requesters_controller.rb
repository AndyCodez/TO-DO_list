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

  private
    def requester_params
      params.permit(:card_id, :user_id)
    end
end
