class AdminController < ApplicationController
  before_action :authorize_admin, only: [:index, :suggest_list, :user]

  def index
    @movies = Movie.where(check: 1).paginate(page: params[:page])
  end
  def review
    @reviews = Review.paginate(page: params[:page]).order("created_at desc")
  end
  def user
    @users = User.paginate(page: params[:page])
  end
  def commentdelete
    @review = Review.find_by id: params[:id]
    # tao noti
    new_uid = @review.user_id
    content1 = "あなたのレビューが削除されました：「#{@review.content}」"
    pic = "delete"

    xem = 0
    sub_id_1 = @review.movie_id
    noti = Noti.new(user_id: new_uid, content: content1, picture: pic, seen: xem, sub_id:  sub_id_1)
    noti.save
    # tao xong noti
    @review.destroy
    @rate = Rate.find_by movie_id: @review.movie_id, user_id: @review.user_id
    @rate.destroy

    flash[:success] = "レビューが削除されました。"
    # cap nhap rate
    @movie = Movie.find sub_id_1
    if @movie.rates.count !=0
      sum = 0
      @movie.rates.each do |rate|
        sum = sum + rate.rate
      end
      @movie.rate_score = 0.1*(sum/@movie.rates.count)*10
    else
      @movie.rate_score = 0
    end
    @movie.save
    redirect_to admin_review_path
  end
  def deactivate
    @user = User.find_by id: params[:id]
    @user.detective= 1
    @user.save
    # tao noti
    new_uid = @user.id
    content1 = "あなたはブロックされました。"
    pic = "block"
    xem = 0
    noti = Noti.new(user_id: new_uid, content: content1, picture: pic, seen: xem, sub_id: 0)
    noti.save
    # tao xong noti
    flash[:success] = "ユーザーをブロックしました。"
    redirect_to admin_user_path
  end
  def undeactivate
    @user = User.find_by id: params[:id]
    @user.detective= 0
    @user.save
    # tao noti
    new_uid = @user.id
    noti = Noti.find_by(user_id: new_uid, sub_id: 0)
    noti.destroy
    # tao xong noti
    redirect_to admin_user_path
  end


  def suggest_list
    @suggested_movies = Movie.where(check: "0").paginate(page: params[:page]).order_desc
  end

  def suggest_confirm
    @suggested_movie = Movie.find_by(id: params[:id])
    @suggested_movie.check = 1
    @suggested_movie.save
    flash[:success] = "確認しました"
    redirect_to @suggested_movie
  end

  private

  def authorize_admin
    redirect_to root_path unless (current_user && current_user.role == "admin")
  end
end
