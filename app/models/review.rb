class Review < ApplicationRecord
  validates :rating, inclusion: (1..10)
end
