class UserLevelsController < ApplicationController

  def execute
    @user_level = UserLevel.find(params[:id])
    @sql_command = params[:sql_command]
    @result = ActiveRecord::Base.connection.execute(@sql_command)
    @values = [] 
    @result.each do |x|
      @values << x
    end
    @string_values = "" 
    @values.each do |hash|
      hash.each do |k,v|
        @string_values << k + "\n"
        @string_values << v + "\n"
      end
    end

    respond_to do |format|
      format.js {
        render :show_output
      }
    end
  end

end
