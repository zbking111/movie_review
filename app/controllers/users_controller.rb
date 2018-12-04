class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def new
    @user = User.new
  end

  def show
    @movies_favorited = Movie.find_by_sql [
       "SELECT * FROM movies WHERE id IN (SELECT movie_id FROM lists WHERE user_id = ? AND list_id = 1)", @user.id
    ]
    @movies_viewed = Movie.find_by_sql [
       "SELECT * FROM movies WHERE id IN (SELECT movie_id FROM lists WHERE user_id = ? AND list_id = 3)", @user.id
    ]
    @movies_will_view = Movie.find_by_sql [
       "SELECT * FROM movies WHERE id IN (SELECT movie_id FROM lists WHERE user_id = ? AND list_id = 2)", @user.id
    ]
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user
    redirect_to root_path
    flash[:danger] = "ユーザがいません。"
  end
end
