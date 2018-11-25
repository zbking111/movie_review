class StaticPagesController < ApplicationController
  before_action :create_movie, only: [:home, :search]
  before_action :find_movie, only: [:home, :search]

  def home
    @top_movies = Movie.where(check:1).rate_score_desc.limit(4)
    @showing_movies = Movie.where(check: 1).date_7_days_ago.date_desc.limit(4)
    @show_soon_movies = Movie.where(check: 1).date_30_days_later.date_asc.limit(4)
  end

  def search
  end

  def top_rating
    @top_movies = Movie.where(check:1).rate_score_desc
                      .paginate(page: params[:page], per_page: 8, total_entries: 20)
  end

  def showing
    @showing_movies = Movie.where(check: 1).date_7_days_ago.date_desc
                          .paginate(page: params[:page], per_page: 8)
  end

  def show_soon
    @show_soon_movies = Movie.where(check: 1).date_30_days_later.date_asc
                            .paginate(page: params[:page], per_page: 8)
  end

  private

  def find_movie
    @movies = @q.result(distinct: true).includes(:actors).paginate(page: params[:page], per_page: 8)
  end

  def create_movie
    # @movie = Movie.new
    # @movie.rate_score = 0
  end
end
