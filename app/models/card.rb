class Card < ApplicationRecord
  belongs_to :list
  has_many :items
  has_many :requesters
  validates :title, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 40 }
end
