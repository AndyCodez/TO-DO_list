class Requester < ApplicationRecord
  belongs_to :card
  validates_uniqueness_of :user_id, scope: :card_id 
end
