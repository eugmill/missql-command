class PagesController < ApplicationController

  before_action :set_levels

  def index
  	return redirect_to "/users/new" if !current_user
  	if current_user.current_level
  		return redirect to level_path(current_user.current_level)
  	end
  	return redirect_to "/levels/1"
  end

end