class Item < ApplicationRecord
  belongs_to :card
  enum condition:{ "Public": 0, "Private": 1 }
end
