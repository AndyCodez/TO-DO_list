module RequestersHelper
  
  #Refactor this later
  #Returns true if current_user has not requested the said card
  def current_user_is_not_requester?(card_to_check)
    requesters = card_to_check.requesters
    requesters.each do |requester|
      if requester.user_id == current_user.id
        return false
      end
    end
  end

end
