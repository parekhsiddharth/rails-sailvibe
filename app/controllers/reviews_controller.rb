class ReviewsController < ApplicationController
  def new
    @review = Review.new(yacht_id: params[:yacht_id])
  end

  def create
    @review = Review.new(review_params)
    if @review.valid?
      @review.save
      redirect_to yacht_path(id: @review.yacht_id)
    else
      @review = Review.new
      render 'yacht/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content, :yacht_id, :user_id)
  end
end
