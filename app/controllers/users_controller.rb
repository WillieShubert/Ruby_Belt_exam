class UsersController < ApplicationController
  skip_before_action :require_login, only: [:index, :create]
  before_action :correct_user, only: [:destroy]

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def create
  @user = User.create(user_params)
    if @user.valid?
      session[:user_id] = @user[:id]
      redirect_to "/user/#{@user.id}"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to '/'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to('/') unless current_user === @user
  end

end
