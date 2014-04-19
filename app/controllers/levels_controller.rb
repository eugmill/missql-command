class LevelsController < ApplicationController
  before_action :authorize
  before_action :set_levels
  before_action :record_logged_in

  def show
    @level = Level.find_by(:stage_number => params[:stage_number])
    @level_pages = @level.ordered_pages
    if @level != current_user.current_level
      current_user.load_level(@level)
    end
  end

end
