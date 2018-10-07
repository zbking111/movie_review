class MoviesController < ApplicationController
  def show
    @movie = Movie.new
    @m = Movie.find(params[:id])
  end
  def create
    @movie = Movie.new movie_params
    byebug
    if @movie.save
      params[:movie][:characters_attributes].each do |a|
        act = Actor.find_by(name: a[1][:name])
        if act.blank? 
          r = Actor.new(name: a[1][:name])
          r.save
          mc = MovieCharacter.new movie_id: @movie.id, actor_id: r.id
          mc.save
        else
          mc = MovieCharacter.new movie_id: @movie.id, actor_id: act.id
          mc.save
        end
      end
      flash[:success] = "successful"
      redirect_to root_path
    else
      flash[:danger] = "failed"
      redirect_to root_path
    end
  end
  
  private

  def movie_params
    params.require(:movie).permit :name, :info, :date, :picture, characters_attribute: [:name]
  end
end
