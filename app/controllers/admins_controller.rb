class AdminsController < ApplicationController
  def index
  	 @movies = Movie.paginate(page: params[:page])
  end
  def destroy
    Movie.find(params[:id]).destroy
    flash[:success] = "Movie deleted"
    redirect_to movies_url
  end
end
