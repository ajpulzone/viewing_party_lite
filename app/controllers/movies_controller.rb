class MoviesController < ApplicationController
  def index
    if session[:user_id]
      @user = current_user
      if params[:top_rated].present?
        @top_rated_movies = MovieFacade.top_rated
      else
        params[:keyword]
        @keyword = params[:keyword]
        @results = MovieFacade.search_movies(@keyword)
      end
    else  
      flash[:alert]= "You must be logged in"
      redirect_to "/dashboard/movies/#{params[:movie_id]}"
    end 
  end

  def show
    if session[:user_id]
      @user = current_user
      id = params[:movie_id]
      @movie = MovieFacade.movie_id(id)
      @reviews = MovieFacade.movie_reviews(id)
      @cast = MovieFacade.movie_cast(id)
    else
      flash[:alert]= "You must be logged in"
      redirect_to "/dashboard/movies/#{params[:movie_id]}"
    end
  end
end
