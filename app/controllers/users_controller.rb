class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      redirect_to @user
      flash[:success] = t ".welcome"
    else
      render "new"
    end
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t ".error_flash"
      redirect_to root_path
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
