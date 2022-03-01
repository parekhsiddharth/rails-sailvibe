class BookingsController < ApplicationController
  def new
    @booking = Booking.new(yacht_id: params[:yacht_id])
  end

  def confirm
    @booking = Booking.new(booking_params)
    if @booking.valid?
      @booking.save
      render 'success'
    else
      @booking = Booking.new
      render 'new'
    end
  end

  def create
    @booking = Booking.new(booking_params)
    if @booking.valid?
      # redirect_to yacht_confirm_booking_path(yacht_id: params[:yacht_id])
    else
      @booking = Booking.new
    end
    render 'new'
  end

  def success
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :yacht_id, :user_id)
  end
end
