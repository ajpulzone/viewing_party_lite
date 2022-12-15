class ViewingPartiesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @users = User.where.not("id = #{params[:user_id]}")
    @movie = MovieFacade.movie_id(params[:movie_id])
    @party = @user.viewing_parties.new
  end

  def create
    user = User.find(params[:user_id])
    @movie = MovieFacade.movie_id(params[:movie_id])
    @party = user.viewing_parties.new(party_params)
    if @party.save
      redirect_to "/dashboard"

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
