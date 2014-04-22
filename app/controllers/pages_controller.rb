class PagesController < ApplicationController

  before_action :set_levels

  def index
  	return redirect_to "/about" if !current_user || current_user.guest?

  	if current_user.current_level
  		return redirect_to "/levels/#{current_user.current_level.stage_number}"
  	end
  end

  def about
  end

end