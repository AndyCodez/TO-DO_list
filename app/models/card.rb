class Card < ApplicationRecord
  belongs_to :list
  has_many :items
  has_many :requesters
end
