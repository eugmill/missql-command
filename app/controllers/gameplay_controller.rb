class GameplayController < ApplicationController
  def execute
    @response = GameResponse.new(current_user, params[:sql_command]).json

    respond_to do |format|
      format.json {
        render json: @response
      }
    end
  end
end
