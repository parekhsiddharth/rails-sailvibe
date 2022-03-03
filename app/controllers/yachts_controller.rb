class YachtsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :find_yacht, only: %i[edit update destroy]

  def index
    if params[:query].present?
      @yachts = Yacht.global_search("%#{params[:query]}%")
    else
      @yachts = Yacht.all
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

  def my_yachts
    @user = current_user
    @my_yachts = @user.yachts
  end

  # def edit
  #   @user = current_user
  #   @my_yachts = @user.yachts[:id]
  # end

  def edit
    # @yacht.user_id = current_user.id
    # @my_yacht = Yacht.find(params[:id])
  end

  def update
    @my_yacht = Yacht.find(params[:id])
    # @my_yacht.user_id = current_user.id
    if @my_yacht.update(yacht_params)
      redirect_to my_yachts_yachts_path
    else
      render 'edit'
    end
  end

  def destroy
    # @my_yacht = Yacht.find(params[:id])
    @my_yacht.destroy
    redirect_to my_yachts_yachts_path
  end

  private

  def yacht_params
    params.require(:yacht).permit(:name, :price, :description, photos: [])
  end

  def find_yacht
    @my_yacht = Yacht.find(params[:id])
  end
end
