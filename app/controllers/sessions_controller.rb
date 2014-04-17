class SessionsController < ApplicationController

  def new    
    if current_user
      redirect_to '/'
    end
  end

  def create
    user = User.find_by(:email => params[:user][:email])
    if user
      session[:user_id] = user.id
      if user.current_level
        return redirect_to "/levels/#{user.current_level.stage_number}"
      else
        return redirect_to "/levels/1"
      end
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
