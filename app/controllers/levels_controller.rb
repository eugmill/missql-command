class LevelsController < ApplicationController

  before_filter :authorize

  def show
    @level = Level.find_by(:stage_number => params[:id])
    @user_level = UserLevel.find_or_create_by(:user_id => current_user.id, :level_id => @level.id)
    if @level != current_user.current_level
      current_user.user_database.load_level(@level)
    end
  end

end