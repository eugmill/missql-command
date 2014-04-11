class GameplayController < ApplicationController

  def execute
    @response = GameResponse.new(current_user, params[:sql_command])

    # @output = current_user.user_database.execute(@sql_command)
    
    @values = @response.result_array.to_s
    @notice = @response.correct?.to_s

    # @string_values = "" 
    
    # @values[0].each do |k,v|
    #   @string_values << k + " | "
    # end
    
    # @string_values << "\n"
    
    # @values.each do |hash|
    #   hash.each do |k,v|
    #     @string_values << v + " | "
    #   end
    # @string_values << "\n"      
    # end

    respond_to do |format|
      format.js {
        render :show_output
      }
    end
  end

end
