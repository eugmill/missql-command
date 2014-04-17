class GameplayController < ApplicationController
  def execute
    @response = GameResponse.new(current_user, params[:sql_command])
    
    if @response.correct?
        current_user.mark_current_complete
    end

    respond_to do |format|
      format.json {
        render json: @response.json
      }
    end
  end
end
