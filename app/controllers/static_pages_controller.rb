class StaticPagesController < ApplicationController
  before_action :create_movie, only: [:home, :search]
  def home
    find_movie
  end

  def search
    find_movie
  end

  private

  def find_movie
    @movies = @q.result(distinct: true).includes(:actors)
  end

  def create_movie
    @movie = Movie.new
    @movie.rate_score = 0
  end
end
