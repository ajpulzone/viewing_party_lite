class ViewingPartiesController < ApplicationController

  def new
    if session[:user_id]
      @user = current_user
      @users = User.where.not(id: current_user.id)
      @movie = MovieFacade.movie_id(params[:movie_id])
      @party = @user.viewing_parties.new
    else
      flash[:alert]= "You must be logged in"
      redirect_to "/dashboard/movies/#{params[:movie_id]}"
    end 
  end

  def create
    if session[:user_id]
      @user = current_user
      user = User.find(params[:user_id])
      @movie = MovieFacade.movie_id(params[:movie_id])
      @party = user.viewing_parties.new(party_params)
        if @party.save
          redirect_to "/dashboard"
        end 
    else
      flash[:alert] = "Error: #{error_message(@party.errors)}"
      redirect_to new_user_movie_viewing_party_path(user.id, @movie.id)
    end
end 

  private

  def party_params
    params.permit(:duration, :date, :start_time)
  end
end
