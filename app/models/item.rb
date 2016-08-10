class Item < ApplicationRecord
  belongs_to :card
  enum condition:{ "Public": 0, "Private": 1 }
  enum status:{ "incomplete": 0, "done": 1 }
  validates :activity, presence: true, length: { maximum: 50 }
end
