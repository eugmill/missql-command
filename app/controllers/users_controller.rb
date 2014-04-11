class UsersController < ApplicationController
  before_filter :authorize, :only => :show

  def new
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)
    if @user.save
      session[:user_id]=@user.id
      redirect_to @user
    else
      flash[:alert] = @user.errors.full_messages.join('. ')
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