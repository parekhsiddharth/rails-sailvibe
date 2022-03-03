class Yacht < ApplicationRecord
  belongs_to :user

  has_many :bookings, through: :user, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, :price, presence: true
  has_many_attached :photos

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :location, :description, :price],
    using: {
      tsearch: { prefix: true }
    }
end
