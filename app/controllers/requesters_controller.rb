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
    requesters = Requester.where(status: 'unresponded')
    @requesters = []
    requesters.each do |requester|
      @requesters.push(requester) unless requester.user_id == current_user.id
    end
  end

  def accept_request
    request = Requester.find(params[:request_id])
    request.update_attribute(:status, "accepted")
    flash[:success] = "Request has been accepted!"
    redirect_to requested_cards_path
  end

  def accepted_requests_list
    @requests = Requester.where(user_id: current_user.id, status: "accepted")
  end

  private
    def requester_params
      params.permit(:card_id, :user_id)
    end
end
