class UsersController < ApplicationController
  before_action :authorize
  before_action :set_levels

  def new
    if current_user && !current_user.guest?
      redirect_to '/'
    end
    @user = User.new
  end

  def create
    @user = User.new(new_user_params)

    if @user.save
      session[:user_id]=@user.id
      redirect_to "/levels/1"
    else
      flash[:alert] = @user.errors.full_messages.join('. ')
      render :new
    end
  end

  private
  def new_user_params
    params.require(:user).permit(:user_name,:email,:password,:password_confirmation,:guest) 
  end

end
