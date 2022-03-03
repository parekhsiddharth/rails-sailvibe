class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @my_bookings = @bookings.where(user: current_user)
  end

  def new
    @booking = Booking.new(yacht_id: params[:yacht_id])
  end

  def confirm
    @booking = Booking.new(booking_params)
    @booking.user_id = current_user.id
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
    @booking.user_id = current_user.id
    if @booking.valid?
      # redirect_to yacht_confirm_booking_path(yacht_id: params[:yacht_id])
      render 'new'
    else
      @booking = Booking.new
      flash[:alert] = "Date not available, please try another date."
      redirect_back(fallback_location: root_path)
    end
  end

  def success
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to yacht_bookings_path(yacht_id: @booking.yacht.id)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :yacht_id, :user_id)
  end
end
