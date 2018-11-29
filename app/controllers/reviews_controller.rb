class ReviewsController < ApplicationController
  def add
    @r = Review.find_by movie_id: params[:review][:movie_id], user_id: params[:review][:user_id]
    if @r
      @s = Rate.find_by movie_id: params[:review][:movie_id], user_id: params[:review][:user_id]
      if params[:review][:rate] == "100"
        movie = Movie.find(@s.movie_id)
        cv = movie.reviews.count # count review
        s = movie.rate_score
        if cv == 1
          s = 0
        else
          s = (s*cv-@s.rate)/(cv-1)
        end
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
        if cv == 1
          s = 0
        else
          s = (s*cv-@s.rate)/(cv-1)
        end
        cv = cv -1

        newRate = s*cv/(10*(cv+1)*0.1)+params[:review][:rate].to_i/(10*(cv+1)*0.1)
        puts
        puts "====="
        puts "s: #{s}, cv: #{cv}, param: #{params[:review][:rate].to_i}, new: #{newRate}"
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

  def like_review
    rid = params[:review][:review_id].to_i
    uid = params[:review][:user_id].to_i
    aid = params[:review][:action].to_i
    rAction = ReviewAction.find_by review_id: rid, user_id: uid
    if rAction #neu da co thi update hoac xoa
      if aid !=0 # update
        rAction.action = aid
        rAction.save

        # update noti
        review1 = Review.find rid
        new_uid = review1.user.id
        user1 = User.find uid
        n =Noti.find_by(user_id: new_uid, sub_id: review1.movie.id)
        if aid == 1
          content1 = "#{user1.name}さんがあなたのレビューに「いいね」しました。"
          pic = "like"
        else
          content1 = "#{user1.name}さんがあなたのレビューに「よくないね」しました。"
          pic = "unlike"
        end
        n.content = content1
        n.picture = pic
        n.save
        # update xong

      else # xoa like
        rAction.destroy
        # xoa noti
        review1 = Review.find rid
        new_uid = review1.user.id
        user1 = User.find uid
        n =Noti.find_by(user_id: new_uid, sub_id: review1.movie.id)
        n.destroy
        # xoa xong
      end
    else # tao like
      action1 = ReviewAction.new(review_id: rid, user_id: uid, action: aid)
      action1.save
      # tao noti
      review1 = Review.find rid
      new_uid = review1.user.id
      user1 = User.find uid
      if aid == 1
        content1 = "#{user1.name}さんがあなたのレビューに「いいね」しました。"
        pic = "like"
      else
        content1 = "#{user1.name}さんがあなたのレビューに「よくないね」しました。"
        pic = "unlike"
      end
      xem = 0
      sub_id_1 = review1.movie.id
      noti = Noti.new(user_id: new_uid, content: content1, picture: pic, seen: xem, sub_id:  sub_id_1)
      noti.save
      # tao xong noti
    end
  end

  private

  def review_params
    params.require(:review).permit :movie_id, :content, :user_id
  end

  def rate_params
    params.require(:review).permit :movie_id, :rate, :user_id
  end
  def action_params
    params.require(:review).permit :review_id,:action, :user_id
  end
end
