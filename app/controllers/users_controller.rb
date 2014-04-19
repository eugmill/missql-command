class UsersController < ApplicationController
  before_filter :authorize, :only => :show
  before_action :set_levels

  def new
    if current_user && !current_user.guest?
      redirect_to '/'
    end
    @user = User.new
  end

  def create
    if(new_user_params["guest"])
      @user = User.new(:guest => true)
      @user.password = "guest"
      @user.password_confirmation = "guest"
      @user.update(new_user_params)
    else
      @user = User.new(new_user_params)
    end

    if @user.save
      session[:user_id]=@user.id
      redirect_to "/levels/1"
    else
      flash[:alert] = @user.errors.full_messages.join('. ')
      render :new
    end
  end

  def about
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def new_user_params
    params.require(:user).permit(:user_name,:email,:password,:password_confirmation,:guest) 
  end

end
