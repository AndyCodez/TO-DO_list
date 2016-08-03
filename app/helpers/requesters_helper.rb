module RequestersHelper
  
  def current_user_is_requester?
    card = Card.find(params[:card_id])
    requesters = card.requesters
    requesters.each do |requester|
      requester.user_id == current_user.id ? true : false
    end
  end

end
