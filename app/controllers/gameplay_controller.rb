class GameplayController < ApplicationController
  def execute
    if params[:sql_command].match(/\bend|\bcommit/i)
      return render json: "{\"query\": \"#{params[:sql_command]}\", \"response\": { \"correct\": false, \"display_type\": \"string\", \"errors\": [\"MISSQL Command does not support short-circuiting transactions. ; )\"]}}"
    elsif params[:sql_command].chars.select{|c| c == ";"}.length > 1
      return render json: "{\"query\": \"#{params[:sql_command]}\", \"response\": { \"correct\": false, \"display_type\": \"string\", \"errors\": [\"MISSQL Command does not support multiple queries in one transaction.\"]}}"
    end

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

  def reset_current
    current_user.user_database.reset
    @text = current_user.current_level.default_text || ""
    respond_to do |format|
      format.json {
        render json: "{\"message\": \"Successfully reset database ✓\", \"displayText\": #{@text.to_json}}"
      }
    end
  end

end
