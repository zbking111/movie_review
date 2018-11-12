class StaticPagesController < ApplicationController
  before_action :create_movie, only: [:home, :search]
  def home
    find_movie
    @movies = Movie.where(check:1).paginate(page: params[:page], per_page: 4).order_desc
  end

  def search
    find_movie
  end

  private

  def find_movie
    @movies = @q.result(distinct: true).includes(:actors).paginate(page: params[:page], per_page: 4)
  end

  def create_movie
    # @movie = Movie.new
    # @movie.rate_score = 0
  end
end
