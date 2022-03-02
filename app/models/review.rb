class Review < ApplicationRecord
  belongs_to :yacht
  belongs_to :user
  validates :rating, inclusion: 0..5
  validates :rating, numericality: { only_integer: true }
end
