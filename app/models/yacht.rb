class Yacht < ApplicationRecord
  belongs_to :user

  has_many :bookings, through: :user, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, :price, presence: true
  has_many_attached :photos
end
