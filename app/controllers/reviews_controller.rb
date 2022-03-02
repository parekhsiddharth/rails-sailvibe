class ReviewsController < ApplicationController
  def new
    @review = Review.new(yacht_id: params[:yacht_id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.valid?
      @review.save
      redirect_to yacht_path(id: @review.yacht_id)
    else
      @review = Review.new
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :yacht_id, :user_id)
  end
end
