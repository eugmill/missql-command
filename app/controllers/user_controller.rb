class UserController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def new_user_params
    params.require(:user).permit(:user_name,:email,:password,:password_confirmation) 
  end

end
