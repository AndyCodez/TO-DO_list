class Requester < ApplicationRecord
  belongs_to :card
  validates_uniqueness_of :user_id, scope: :card_id 
  enum status:{ "unresponded": 0, "accepted": 1, "rejected": 2 }
end
