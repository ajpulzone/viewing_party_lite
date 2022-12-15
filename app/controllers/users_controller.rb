class UsersController < ApplicationController
  def index; end

  def show
    if session[:user_id]
      @user = current_user
    else
      flash[:alert]= "You must be logged in"
      redirect_to "/"
    end 
  end

  def new
    @user = User.new
  end

  def discover
    @user = User.find(params[:user_id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:alert] = "Error: #{error_message(@user.errors)}"
      redirect_to '/register'
    end
  end

  def login_form
  end

  def login_user
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to "/dashboard"
    else
      flash[:alert] = "Credentials Invalid"
      redirect_to "/login"
    end
  end

  def logout_user
    reset_session
    redirect_to "/"
  end

  private
  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
