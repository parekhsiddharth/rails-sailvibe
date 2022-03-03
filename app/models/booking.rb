class Booking < ApplicationRecord
  belongs_to :yacht
  belongs_to :user
  validate :no_booking_overlap

  scope :overlapping, ->(period_start, period_end) do
    where "(( start_date<= ?) and (end_date >= ?))", period_end, period_start
  end

  private

  def no_booking_overlap
    if (Booking.overlapping(start_date, end_date).any?)
      errors.add(:end_date, 'These dates are booked')
    end
  end
end
