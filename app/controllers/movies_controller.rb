class MoviesController < ApplicationController

  def new
    @movie = Movie.new
  end

  def show
  	@movie = Movie.find(params[:id])
    if @movie && @movie.check == 1
  	 find_movie
    else
      redirect_to root_path
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new movie_params
    if current_user.role == "member"
      @movie.check = 0
    else
      @movie.check = 1
    end
    @movie.rate_score = 0
    if @movie.save
      if !params[:movie][:characters_attributes].blank?
        params[:movie][:characters_attributes].each do |a|
          act = Actor.find_by(name: a[1][:name])
          # if act.blank?
          #   r = Actor.new(name: a[1][:name])
          #   r.save
          #   mc = MovieCharacter.new movie_id: @movie.id, actor_id: r.id
          #   mc.save
          # else
          #   mc = MovieCharacter.new movie_id: @movie.id, actor_id: act.id
          #   mc.save
          # end
          mc = MovieCharacter.new movie_id: @movie.id, actor_id: act.id, role: a[1][:role]
          mc.save
        end
      end
      if current_user.role == "member"
        flash[:success] = "管理者に映画を進めました"
        redirect_to root_path
      else
        flash[:success] = "映画を追加しました。"
        redirect_to @movie
      end
    else
      byebug
      flash[:danger] = "エラーが発生しました、もう一度お試しください"
      redirect_to root_path
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if !@movie.update_attributes movie_params
      flash[:danger] = "エラーが発生しました、もう一度お試しください"
    end
    redirect_to admin_index_path
  end

  def destroy
    @movie = Movie.find(params[:id])
    status1 = @movie.check
    @movie.destroy
    flash[:success] = "削除しました"
    if status1 == 1
      redirect_to admin_index_path
    else
      redirect_to admin_suggest_list_path
    end
  end

  private

  def movie_params
    params.require(:movie).permit :name, :info, :date, :picture, characters_attribute: [:name]
  end

  def find_movie
    @q = Movie.search(params[:q])
    @movies = @q.result(distinct: true)
  end
end
