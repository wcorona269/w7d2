class UsersController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], [params[:user][:password])
    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def user_params
    params.require(:user).permit(:email, :password_digest, :password, :session_token)
  end

end
