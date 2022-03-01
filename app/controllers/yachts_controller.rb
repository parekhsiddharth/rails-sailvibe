class YachtsController < ApplicationController
  def index
    @yachts = Yacht.all
  end

  def show
    @yacht = Yacht.find(params[:id])
    @booking = Booking.new(yacht_id: @yacht_id.id)
    @review = Review.new(yacht_id: @yacht_id.id)
  end

  def new
    @yacht = Yacht.new
  end

  def create
    @yacht = Yacht.new(yacht_params)
    if @yacht.save
      redirect_to yacht_path(id: @yacht.id)
    else
      render :new
    end
  end

  private

  def yacht_params
    params.require(:yacht).permit(:name, :price, :description)
  end
end
