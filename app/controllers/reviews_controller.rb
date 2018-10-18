class ReviewsController < ApplicationController
  def add
    @review = Review.new review_params
    @review.save
    @rate = Rate.new rate_params
    @rate.save
  end

  def remove
  end

  private

  def review_params
    params.require(:review).permit :movie_id, :content, :user_id
  end

  def rate_params
    params.require(:review).permit :movie_id, :rate, :user_id
  end
end
