class UsersController < ApplicationController
  before_filter :authorize, :only => :show
  before_action :set_levels

  def new
    if current_user
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

  def show
    @user = User.find(params[:id])
  end

  private
  def new_user_params
    params.require(:user).permit(:user_name,:email,:password,:password_confirmation) 
  end

end
