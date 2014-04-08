class UserController < ApplicationController
  
  def new
    @user = User.new
  end
end
