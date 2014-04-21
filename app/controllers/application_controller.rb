class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= User.find_by(:id => session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    # redirect_to login_path, alert: "Not authorized" if current_user.nil?
    if current_user.nil?
      guest = User.new(:guest => true, :password => "guest", :password_confirmation => "guest")
      guest.save
      session[:user_id] = guest.id
    end
  end

  def record_logged_in
    current_user.update(:last_logged_in => Time.now) if current_user
  end

  def set_levels
    @levels = Level.order(:stage_number)
  end

end