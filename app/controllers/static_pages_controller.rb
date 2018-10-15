class StaticPagesController < ApplicationController
  def home
    @movie = Movie.new
    find_movie
  end

  def search
    find_movie
  end

  private

  def find_movie
    @q = Movie.search(params[:q])
    @movies = @q.result(distinct: true)
  end

end
