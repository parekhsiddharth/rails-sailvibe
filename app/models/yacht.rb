class Yacht < ApplicationRecord
  belongs_to :user

  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :name, :price, presence: true
  has_many_attached :photos


  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :name, :location, :description, :price],
    using: {
      tsearch: { prefix: true }
    }
end
