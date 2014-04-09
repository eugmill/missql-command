class UserLevelsController < ApplicationController

  def execute
    @user_level = UserLevel.find(params[:id])
    @sql_command = params[:sql_command]

    respond_to do |format|
      format.js {
        render :show_output
      }
    end
  end

end
