class LevelsController < ApplicationController

  before_filter :authorize

  def show
    @level = Level.find_by(:stage_number => params[:id])
  end

end
