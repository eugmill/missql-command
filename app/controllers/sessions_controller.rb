class SessionsController < ApplicationController

  def new    
  end

  def create
    user = User.find_by(:user_name => params[:user][:user_name])
    if user
      session[:user_id] = user.id
      redirect_to user
    else
      flash[:notice] = "Email or password is incorrect"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
