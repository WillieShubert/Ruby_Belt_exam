class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:login]

  def login
    @user = User.find_by_email(params[:log_in_email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = ["user logged in"]
      redirect_to "/user/#{@user.id}"
    else
      flash[:notice] = ['Invalid Combination']
      redirect_to '/'
    end
  end

  def logout
    session.delete(:user_id)
    redirect_to '/'
  end
end
