class ReviewsController < ApplicationController
  def add
    @r = Review.find_by movie_id: params[:review][:movie_id], user_id: params[:review][:user_id]
    if @r
      @s = Rate.find_by movie_id: params[:review][:movie_id], user_id: params[:review][:user_id]
      if params[:review][:rate] == "100"
        movie = Movie.find(@s.movie_id)
        cv = movie.reviews.count # count review
        s = movie.rate_score
        s = (s*cv-@s.rate)/(cv-1)
        movie.rate_score = s
        movie.save
        @r.destroy
        @s.destroy
        return
      end
      if params[:review][:rate] != "0"

        movie = Movie.find(@s.movie_id)
        cv = movie.reviews.count # count review
        s = movie.rate_score
        s = (s*cv-@s.rate)/(cv-1)
        cv = cv -1

        newRate = s*cv/(10*(cv+1)*0.1)+params[:review][:rate].to_i/(10*(cv+1)*0.1)
        movie.rate_score = newRate
        movie.save
        @s.update_attributes rate_params
      end
      @r.update_attributes review_params
      return
    end

    movie = Movie.find(params[:review][:movie_id])
    if movie.reviews.count == 0
      movie.rate_score = params[:review][:rate]
    else
      s = movie.rate_score
      cv = movie.reviews.count # count review
      newRate = s*cv/(10*(cv+1)*0.1)+params[:review][:rate].to_i/(10*(cv+1)*0.1)
      movie.rate_score = newRate
    end
    movie.save

    @review = Review.new review_params
    @review.save
    @rate = Rate.new rate_params
    @rate.save
    # movie.rate_score = @rate.rate
    # puts
    # puts "===="
    # puts movie.reviews.count
    # puts movie.reviews.count == 0

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
