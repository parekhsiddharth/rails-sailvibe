class YachtsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @yachts = Yacht.all

    @markers = @yachts.geocoded.map do |yacht|
      {
        lat: yacht.latitude,
        lng: yacht.longitude,
        info_window: render_to_string(partial: "info_window", locals: { yacht: yacht })
      }
    end
  end

  def show
    @yacht = Yacht.find(params[:id])
    @booking = Booking.new(yacht_id: @yacht.id)
    @review = Review.new(yacht_id: @yacht.id)
  end

  def new
    @yacht = Yacht.new
  end

  def create
    @yacht = Yacht.new(yacht_params)
    @yacht.user_id = current_user.id
    if @yacht.save
      redirect_to yacht_path(id: @yacht.id)
    else
      render :new
    end
  end

  private

  def yacht_params
    params.require(:yacht).permit(:name, :price, :description, :location, photos: [])
  end
end
