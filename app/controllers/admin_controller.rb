class AdminController < ApplicationController
  before_action :authorize_admin, only: [:index, :suggest_list]

  def index
    @movies = Movie.where(check: 1).paginate(page: params[:page])
  end

  def user
    @users = User.paginate(page: params[:page])
  end

  def deactivate
    @user = User.find_by id: params[:id]
    @user.detective= 1
    @user.save
    flash[:success] = "ユーザーをブロックしました。"
    redirect_to admin_user_path
  end
  def undeactivate
    @user = User.find_by id: params[:id]
    @user.detective= 0
    @user.save
    flash[:success] = "User UnBlocked"
    redirect_to admin_user_path
  end
  def suggest_list
    @suggested_movies = Movie.where(check: "0").paginate(page: params[:page]).order_desc
  end

  def notification

  end

  def suggest_confirm
    @suggested_movie = Movie.find_by(id: params[:id])
    @suggested_movie.check = 1
    @suggested_movie.save
    flash[:success] = "確認しました"
    redirect_to admin_suggest_list_path
  end

  private

  def authorize_admin
    redirect_to root_path unless (current_user && current_user.role == "admin")
  end
end
