class BookingsController < ApplicationController
  def new
    @booking = Booking.new(yacht_id: params[:yacht_id])
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.valid?
      @booking.save
      redirect_to yacht_path(id: @booking.yacht_id)
    else
      @booking = Booking.new
      render 'yacht/show'
    end
  end

  private

  def booking_params
    params.require(:review).permit(:rating, :content, :yacht_id, :user_id)
  end
end
